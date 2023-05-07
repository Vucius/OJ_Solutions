require 'http'
require 'uri'
require 'json'
require 'glimmer-dsl-libui'

$title = ''
$title_id = nil
$aim_url = 'https://leetcode.com/graphql/'
$ccoo = ''
$ctx = OpenSSL::SSL::SSLContext.new
$ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
def readccoo
  fcc = File.open("./cc")
  $ccoo = fcc.readline.chomp
  fcc.close
end

def check_coo
  ccoo_data = {
    "query": "\n    query globalData {\n  userStatus {\n    userId\n    isSignedIn\n    isMockUser\n    isPremium\n    isVerified\n    username\n    avatar\n    isAdmin\n    isSuperuser\n    permissions\n    isTranslator\n    activeSessionId\n    checkedInToday\n    notificationStatus {\n      lastModified\n      numUnread\n    }\n  }\n}\n    ",
    "variables": {},
    "operationName": "globalData"
  }
  ccoo_headers = {
    'content-type' => 'application/json',
    'Cookie' => $ccoo
  }
  userid_data = HTTP.post(URI($aim_url), :body => ccoo_data.to_json, :headers => ccoo_headers, :ssl_context => $ctx)
  userid_json = JSON.load(userid_data.body)
  userid_json["data"]["userStatus"]["userId"].nil?
end

def analysis_question_title_slug(title_slug)
  #检查题目名称对不对
  title_slug_query =
    {
      "query": "\n    query tabsStatus($titleSlug: String!) {\n  questionTopicsList(questionSlug: $titleSlug) {\n    totalNum\n  }\n  questionDiscussionTopic(questionSlug: $titleSlug) {\n    topLevelCommentCount\n  }\n}\n    ",
      "variables": {
        "titleSlug": title_slug
      },
      "operationName": "tabsStatus"
    }
  title_slug_header = {
    'content-type' => 'application/json',
    'Cookie' => $ccoo
  }
  title_slug_data = HTTP.post(URI($aim_url), :body => title_slug_query.to_json, :headers => title_slug_header, :ssl_context => $ctx)
  title_slug_data_json = JSON.load(title_slug_data.body)
  #num = title_slug_data_json["data"]["questionTopicsList"]["totalNum"]
  tmp_content = title_slug_data_json["data"]["questionDiscussionTopic"]
  #p num
  !tmp_content.nil?
end

def return_submissionlist(lc_title_slug)
  #获取通关的id
  ans = []
  submissionlist_data_query =
    {
      "query": "\n    query submissionList($offset: Int!, $limit: Int!, $lastKey: String, $questionSlug: String!, $lang: Int, $status: Int) {\n  questionSubmissionList(\n    offset: $offset\n    limit: $limit\n    lastKey: $lastKey\n    questionSlug: $questionSlug\n    lang: $lang\n    status: $status\n  ) {\n    lastKey\n    hasNext\n    submissions {\n      id\n      title\n      titleSlug\n      status\n      statusDisplay\n      lang\n      langName\n      runtime\n      timestamp\n      url\n      isPending\n      memory\n      hasNotes\n    }\n  }\n}\n    ",
      "variables": {
        "questionSlug": lc_title_slug,
        "offset": 0,
        "limit": 20,
        "lastKey": nil
      },
      "operationName": "submissionList"
    }
  submissionlist_data_header = {
    'content-type' => 'application/json',
    'Cookie' => $ccoo
  }
  submissionlist_data = HTTP.post(URI($aim_url), :body => submissionlist_data_query.to_json, :headers => submissionlist_data_header, :ssl_context => $ctx)
  submissionlist_data_json = JSON.load(submissionlist_data.body)
  tmp_json = submissionlist_data_json["data"]["questionSubmissionList"]["submissions"]
  $title = tmp_json[0]["title"]
  tmp_json.each do |ttt|
    if ttt["statusDisplay"] == "Accepted"
      ans.push(return_selected_code(ttt["id"]))
    end
  end
  ans
end

def return_selected_code(submissionid)
  selected_code_query =
    {
      "query": "\n    query submissionDetails($submissionId: Int!) {\n  submissionDetails(submissionId: $submissionId) {\n    runtime\n    runtimeDisplay\n    runtimePercentile\n    runtimeDistribution\n    memory\n    memoryDisplay\n    memoryPercentile\n    memoryDistribution\n    code\n    timestamp\n    statusCode\n    user {\n      username\n      profile {\n        realName\n        userAvatar\n      }\n    }\n    lang {\n      name\n      verboseName\n    }\n    question {\n      questionId\n    }\n    notes\n    topicTags {\n      tagId\n      slug\n      name\n    }\n    runtimeError\n    compileError\n    lastTestcase\n  }\n}\n    ",
      "variables": {
        "submissionId": submissionid.to_i
      },
      "operationName": "submissionDetails"
    }
  selected_code_header = {
    'content-type' => 'application/json',
    'Cookie' => $ccoo
  }
  selected_code_data = HTTP.post(URI($aim_url), :body =>selected_code_query.to_json, :headers => selected_code_header, :ssl_context => $ctx)
  selected_code_json = JSON.load(selected_code_data.body)
  if $title_id.nil?
    $title_id = selected_code_json["data"]["submissionDetails"]["question"]["questionId"]
    $title = $title_id + ". " + $title
  end
  json_format(selected_code_json["data"]["submissionDetails"], submissionid)
end

def json_format(aim, id)
  if aim["runtimePercentile"].nil?
    aim["runtimePercentile"] = "N/A"
  else
    aim["runtimePercentile"] = aim["runtimePercentile"].to_f.round(2)
  end
  if aim["memoryPercentile"].nil?
    aim["memoryPercentile"] = "N/A"
  else
    aim["memoryPercentile"] = aim["memoryPercentile"].to_f.round(2)
  end
  [
    aim["lang"]["name"],
    aim["runtimeDisplay"], aim["runtimePercentile"].to_f,
    aim["memoryDisplay"], aim["memoryPercentile"].to_f,
    aim["code"], id
  ]
end

def return_selected(arr)
  ans = []
  arr.each do |arrs|
    ans << arrs if arrs[-1]
  end
  ans
end
class OutputUI

  Data = Struct.new(:lang_name, :runtime, :runtime_percentile, :memory, :memory_percentile, :code, :id)

  class Basic_table < Data
    def lang_name_color
      color = case lang_name
              when 'ruby'
                :red
              when 'cpp'
                :green
              end
      [lang_name, color]
    end

    def runtime_percentile_color
      color = nil
      if runtime_percentile.to_f == 100
        color = :red
      elsif runtime_percentile.to_f >= 80
        color = :blue
      else
        color = :brown
      end
      [runtime_percentile, color]
    end

    def memory_percentile_color
      color = nil
      if memory_percentile.to_f == 100
        color = :red
      elsif memory_percentile.to_f >= 80
        color = :blue
      else
        color = :brown
      end
      [memory_percentile, color]
    end

    def background_color
      case lang_name
      when 'ruby'
        { r: 255, g: 120, b: 0, a: 0.5 }
      when 'cpp'
        '#13a1fb'
      else
        :skyblue
      end
    end

  end

  include Glimmer
  attr_accessor :question_slug, :table_detail, :width

  def initialize(title_slug)
    @question_slug = title_slug
    @table_detail = Array.new
    temp = return_submissionlist(@question_slug)
    temp.each do |ttt|
      @table_detail << Basic_table.new(*ttt)
    end
    @width = 83 + 21 * (@table_detail.count + 1)

  end

  def lanuch
    window(@question_slug, 604, @width) { |out_w|
      #614 604
      #724
      vertical_box {
        horizontal_box {
          # 语言名称 用时 击败多少 内存击败多少
          @show_table = table {
            text_color_column('Lang')
            text_column('Runtime')
            text_color_column('RuntimePercentile') {
              on_clicked do |tc, column|
                accurate_soft_column(tc, column)
              end
            }
            text_column('Memory')
            text_color_column('MemoryPercentile') {
              on_clicked do |tc, column|
                accurate_soft_column(tc, column)
              end
            }

            background_color_column

            cell_rows <= [self, :table_detail,
                          column_attributes: { 'Lang' => :lang_name_color, 'RuntimePercentile' => :runtime_percentile_color, 'MemoryPercentile' => :memory_percentile_color }
            ]
            selection_mode :zero_or_many
            sortable false

            on_selection_changed do |t, selection, added_selection, removed_selection|
              # selection is an array or nil if selection mode is zero_or_many
              # otherwise, selection is a single index integer or nil when not selected
            end

          }
        }
        horizontal_box {
          stretchy false
          # 退回 複製 生成文件
          button('返回') {
            on_clicked do
              out_w.destroy
              $title = ''
              $title_id = nil
              IntputUI.launch
            end
          }
          button('复制') {
            on_clicked do
              #檢查 是否選中
              if @show_table.selection.nil? || @show_table.selection.count != 2
                msg_box('tips', '只能選擇2個')
              elsif @table_detail[@show_table.selection[0]][0] == @table_detail[@show_table.selection[1]][0]
                msg_box('tips', '各選一個')
              else
                a = @show_table.selection[0]
                b = @show_table.selection[1]
                tmp_str =
                  "# [**#{@table_detail[a][0].capitalize}**](https://leetcode.com/problems/" +
                    @question_slug + "/submissions/#{@table_detail[a][-1]}/)\n```\n" +
                    @table_detail[a][-2] +
                    "\n```\n\n# [**#{@table_detail[b][1][0].capitalize}**](https://leetcode.com/problems/" +
                    @question_slug + "/submissions/#{@table_detail[b][-1]}/)\n```\n" +
                    @table_detail[b][-2] + "\n```\n\n"
                IO.popen('clip', 'w') { |out| out.puts tmp_str.to_s }
              end
            end
          }
          button('生成') {
            on_clicked do
              if @show_table.selection.nil? || @show_table.selection.count != 2
                msg_box('tips', '只能選擇2個')
              elsif @table_detail[@show_table.selection[0]][0] == @table_detail[@show_table.selection[1]][0]
                msg_box('tips', '各選一個')
              else
                a = @show_table.selection[0]
                b = @show_table.selection[1]
                Dir.mkdir("../LeetCode_Solutions") unless File.directory?("../LeetCode_Solutions")
                if File.exist?("../LeetCode_Solutions/#{$title}.org")
                  msg_box_error('Check failed!', "#{$title}文件已存在!")
                else
                  new_file = File.open("../LeetCode_Solutions/#{$title}.org", "w")
                  org_output = "#+title: #{$title}\n#+author: 钟离眜\n\n#+begin_src " +
                    @table_detail[a][0].downcase + "\n" +
                    @table_detail[a][-2] + "\n#+end_src\n\n\n#+begin_src " +
                    @table_detail[b][0].downcase + "\n" + @table_detail[b][-2] +
                    "\n#+end_src\n"
                  new_file.puts(org_output)
                  new_file.close
                  msg_box('文件寫入已完成', "即將退出程序")
                  #sleep(5)
                  exit
                end
              end
            end
          }
        }
      }

    }.show
  end

  def accurate_soft_column(tc, column)
    selected_rows = @show_table.selection&.map { |row| @table_detail[row] }
    tc.toggle_sort_indicator
    @table_detail.sort_by! do |row_data|
      [row_data[0], row_data[column] == "N/A" ? Float::INFINITY : row_data[column].to_f]
    end
    @table_detail.reverse! if tc.sort_indicator == :descending
    @show_table.selection = selected_rows&.map { |row_data| @table_detail.index(row_data) }
  end

end

class IntputUI

  include Glimmer::LibUI::Application

  attr_accessor :title_slug

  #def initialize
  #  @title_slug = ''
  #end

  after_body do
    readccoo
    if check_coo
      msg_box_error('Check failed!', 'Something odd happened!')
      exit(1)
    end
  end
  body do
    window('输入题目名称', 400, 100) { |entrance_window|
      margined true

      vertical_box {
        form {
          entry {
            label '请输入Title'
            text <=> [self, :title_slug] # bidirectional data-binding between entry text and self.name
          }
        }

        horizontal_box {
          vertical_box {
          }
          button('确定') {
            on_clicked do
              #检查信息 传递信息 摧毁本窗口 新建窗口
              if analysis_question_title_slug(self.title_slug)
                entrance_window.destroy
                OutputUI.new(self.title_slug).lanuch
                #LibUI.quit
              else
                msg_box('error!', 'title slug error')
              end
            end
          }
          vertical_box {
          }
        }
      }
    }
  end

end


IntputUI.launch