require 'glimmer-dsl-tk'
require 'http'

$ccoo = 'csrftoken=lhbajjINTKv4xCgINhzlqyAm9k5iVkLP658dLrKFMOi5UK98zMzg55HwpCSNJbEr; LEETCODE_SESSION=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfYXV0aF91c2VyX2lkIjoiNzUxNjkxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWxsYXV0aC5hY2NvdW50LmF1dGhfYmFja2VuZHMuQXV0aGVudGljYXRpb25CYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzlkOGYxMGU1OGE3OWNlNjgwOTJiYTViZTkxOTAxY2MyN2RkZDY3YSIsImlkIjo3NTE2OTEsImVtYWlsIjoiNzgwMjAyNjgxQHFxLmNvbSIsInVzZXJuYW1lIjoiVnVjaXVzIiwidXNlcl9zbHVnIjoiVnVjaXVzIiwiYXZhdGFyIjoiaHR0cHM6Ly9zMy11cy13ZXN0LTEuYW1hem9uYXdzLmNvbS9zMy1sYy11cGxvYWQvYXNzZXRzL2RlZmF1bHRfYXZhdGFyLmpwZyIsInJlZnJlc2hlZF9hdCI6MTY2MTYwMTg5OCwiaXAiOiIxMTMuMTA5LjU5LjEwMCIsImlkZW50aXR5IjoiYjIwZjk2ZTU4NzhiMGE0N2ZmODYyNmM4Zjc1N2UzNWIiLCJzZXNzaW9uX2lkIjoyNjczOTQ3NywiX3Nlc3Npb25fZXhwaXJ5IjoxMjA5NjAwfQ.e1fPPeJ9NgxtJBvKj_WY5I8PsN-JdWslS9FRArpgUlQ; NEW_PROBLEMLIST_PAGE=1; c_a_u=VnVjaXVz:1oSHzY:PDErRk6BrNcFan68AVaT4Rxebfk'

def fyi(number)
  case number
  when 0
    return '未解析'
  when 1
    return '未解析ruby'
  when 2
    return '未解析cpp'
  when 3
    return '解析完毕'
  else
    return '重复解析了 请重置'
  end
end

class OJ_Window
  include Glimmer
  attr_accessor :cppcode, :rubycode, :cppurl, :rubyurl, :state, :sss, :output

  def initialize
    @cppurl = ''
    @rubyurl = ''
    @state = '未解析'
    @sss = 0
    @cppcode = ''
    @rubycode = ''
  end

  def launch
    root {
      title "Leetcode Solutions save"
      resizable true, true
      background '#49A'#background color
      frame {
        grid row: 0, column: 0, row_weight: 1, column_weight: 4
        relief 'sunken'
        label {
          grid row: 0, column: 0, column_span: 1
          text "cpp"
        }
        @cpp_entry = entry {
          grid row: 0, column: 1, sticky: 'ew', column_span: 2
          text <=> [self, :cppurl]
        }
        button { |b|
          grid row: 0, column: 3, column_span: 1
          text "解析"
          default 'active'
          focus true

          on('command') do
            pattern = /https:\/\/leetcode.com\/submissions\/detail\/(\d+)\//
            if @cpp_entry.text.match(pattern).nil?
              message_box(title: 'error', message: '错误的链接')
            else
              ac_html = HTTP.cookies(:session => $ccoo).get(@cppurl)
              if ac_html.nil?
                message_box(title: 'error', message: '获取代码失败。')
              else
                if 'cpp' != /(?<=getLangDisplay: \')(.*)(?=\',)/.match(bbb = ac_html.body).to_s
                  message_box(title: 'error', message: '该链接的ac代码并非cpp代码')
                else
                  @cppcode = /(?<=submissionCode: \')(.*)(?=\',)/.match(bbb).to_s
                  @sss += 1
                  @state_label.text = fyi(@sss)
                end
              end
            end
          end
        }
      }
      frame {
        grid row: 1, column: 0, row_weight: 1, column_weight: 4
        relief 'sunken'
        label {
          grid row: 0, column: 0, pady: 5, column_span: 1
          text "ruby"
        }
        @ruby_entry = entry {
          grid row: 0, column: 1, sticky: 'ew', column_span: 2
          text <=> [self, :rubyurl]
        }
        button {
          grid row: 0, column: 3, pady: 5, column_span: 1
          text "解析"
          on('command') do
            pattern = /https:\/\/leetcode.com\/submissions\/detail\/(\d+)\//
            if @ruby_entry.text.match(pattern).nil?
              message_box(title: 'error', message: '错误的链接')
            else
              ac_html = HTTP.cookies(:session => $ccoo).get(@rubyurl)
              if ac_html.nil?
                message_box(title: 'error', message: '获取代码失败。')
              else
                if 'ruby' != /(?<=getLangDisplay: \')(.*)(?=\',)/.match(bbb = ac_html.body).to_s
                  message_box(title: 'error', message: '该链接的ac代码并非ruby代码')
                else
                  @rubycode = /(?<=submissionCode: \')(.*)(?=\',)/.match(bbb).to_s
                  @sss += 2
                  @state = fyi(@sss)
                end
              end
            end
          end
        }
      }
      @state_frame = frame {
        grid row: 0, column: 1, row_weight: 1, column_weight: 2
        label {
          grid row: 0, column: 0, column_span: 1
          text "状态"
        }
        @state_label = label {
          grid row: 0, column: 1, pady: 5, column_span: 1
          text <=> [self, :state]
        }
      }
      frame {
        grid row: 1, column: 1, row_weight: 1, column_weight: 3
        button {
          grid row: 0, column: 0, pady: 5, column_span: 1
          text "重置"
          on('command') do
            @cppurl = ''
            @rubyurl = ''
            @state = '未解析'
            @sss = 0
            @cppcode = ''
            @rubycode = ''
          end
        }

        button {
          grid row: 0, column: 1, pady: 5, column_span: 1
          text "复制"
          on('command') do
            if (@state_label.text != '解析完毕')
              message_box(title: 'Miss', message: '解析不完整或者重复解析')
            else
              @output = "# [**C++**](#{@cppurl})\n```\n" +
                @cppcode + "\n```\n\n# [**Ruby**](#{@rubyurl})\n```\n" +
                @rubycode + "\n```\n\n"
              IO.popen('clip', 'w') {|out| out.puts @output}
            end
          end
        }
      }
      #background '#0059b3'
    }.open
  end

end
OJ_Window.new.launch

