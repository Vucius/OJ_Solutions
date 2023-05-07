require 'http'
require 'json'
require 'glimmer-dsl-libui'

$ccoo = ''
$ctx = OpenSSL::SSL::SSLContext.new
$ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
def checkccoo
  return false unless File.exist?("./cc")
  tmp_f = IO.readlines("./cc")
  $ccoo = tmp_f[1].to_s
  tmp_u = "https://www.codewars.com/dashboard"
  ac = HTTP.cookies(:session => $ccoo).get(tmp_u, :ssl_context => $ctx)
  ac.code != 200
end

def check_links(checking_str)
  regex = /^https:\/\/www\.codewars\.com\/kata\/reviews\/[a-zA-Z0-9]{24}\/groups\/[a-zA-Z0-9]{24}$/
  !checking_str.match?(regex)
end

def read_and_write(aim)
  #獲取資源
  ac_html = HTTP.cookies(:session => $ccoo).get(aim, :ssl_context => $ctx)
  txt = ac_html.to_s
  tname = /(?<=data-challenge\=)(.*)(?=Total collections)/.match(txt).to_s
  tname.sub!(" data-tippy-content=\"", "")
  tname.gsub!("\"", "")
  tname.gsub!("&quot;", '"')
  tmp_hash = JSON.load(tname)
  name = tmp_hash["name"]

  kyu_con = /(?<=float-left mr-15px)(.*)(?=mt-5px)/.match(txt).to_s
  kyu_number = /(?<=span>)(.*)(?=<\/span><\/div)/.match(kyu_con).to_s
  ac_json = /(?<=JSON.parse\()(.*)(?=\)\,)/.match(txt).to_s
  ans_json_t = JSON.load(ac_json)
  ans_json = JSON.load(ans_json_t)
  solution_lang = ans_json["activeLanguage"]
  solution_code = ans_json["solution"]
  #檢查文件路徑
  str_path = "../"
  case solution_lang
  when "ruby"
    str_path += "CodeWars_Ruby_solution"
    name += ".rb"
  when "cpp"
    str_path += "CodeWars_Cpp_solution"
    name += ".cpp"
  end
  Dir.mkdir(str_path) unless File.directory?(str_path)
  str_path += "/" + kyu_number
  Dir.mkdir(str_path) unless File.directory?(str_path)
  str_path += "/" + name
  return str_path if File.exist?(str_path)
  f_new = File.open(str_path, "w")
  aim = "# " + aim
  f_new.puts(aim)
  f_new.puts(solution_code)
  f_new.close
  name
end


class CWsolutionscopyer

  include Glimmer::LibUI::Application

  attr_accessor :links

  #def initialize
  #  @title_slug = ''
  #end

  after_body {
    if checkccoo
      msg_box_error('Check failed!', 'Something odd happened!')
      exit(1)
    end
  }
  body {
    window('请输入链接', 400, 50) { |main_window|
      margined true

      horizontal_box {

        entry {
          text <=> [self, :links]
        }
        button("確定"){
          on_clicked do
            if check_links(self.links)
              msg_box('Links error!', 'Please enter a valid link.')
            else
              get_return = read_and_write(self.links)
              if get_return =~ /^\.\.\//
                msg_box('Check failed!', "#{get_return}文件已存在!")
              else
                msg_box('Godd!', "成功写入#{get_return}")
                self.links = nil
              end
            end
          end
        }

      }
    }
  }

end


CWsolutionscopyer.launch
