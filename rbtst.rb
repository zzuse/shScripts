#!/opt/exp/bin/ruby -w

class Para
  attr :line, :index
  def initialize
    @line = String.new
    @index = 0
  end

  def append(aline)
    @line += aline
    @index += 1
  end

  def to_s
    puts @line
  end

  def squeeze  
    @line.gsub!(/\s+/, '')
  end

  def striptime
    @line.slice(19, 8)
  end

  def stripmsg
     ((@line.split(/ProfileID/)[1]).split(/\_/))[1]
  end

  def stripIMSI
    (@line.split(/mSubIdNum=/))[1].split(/\,/)[0]
  end
  def stripop
    if @line =~ /retryloadDataprofile/ then
      @optype = "retry"
    else
      @optype = "failure"
    end
  end
end


class Record
  attr_accessor :time
  attr_accessor :msgtype
  attr_accessor :optype
  attr_accessor :imsi

  def to_s
    puts "#{@time},#{@imsi},#{@msgtype},#{@optype}"
  end
end

file = File.open($*[0])

while file.gets
  #puts $_, "\n"
  aline = ($_).chomp
  #puts aline
  if aline =~ /\+\+\+/
    apara = Para.new
    apara.append(aline)
    while file.gets do
      nextline = ($_).chomp
      apara.append(nextline)
      if nextline =~ /END OF REPORT/
        re = Record.new
        apara.squeeze
        if apara.line =~ /GD::Exception/ then 
          re.time = apara.striptime
          re.msgtype =  apara.stripmsg
          re.optype = apara.stripop
          re.imsi = apara.stripIMSI
          re.to_s
        end
        break;
      end
    end
  end
end
