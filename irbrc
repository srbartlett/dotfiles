require 'rubygems'
require 'pp'
require 'irb/completion'
require 'irb/ext/save-history'

# adds readline functionality
IRB.conf[:USE_READLINE] = true
# auto indents suites
IRB.conf[:AUTO_INDENT] = true
# where history is saved
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"
# how many lines to save
IRB.conf[:SAVE_HISTORY] = 1000

# don't save duplicates
IRB.conf[:AT_EXIT].unshift Proc.new {
    no_dups = []
    Readline::HISTORY.each_with_index { |e,i|
        begin
            no_dups << e if Readline::HISTORY[i] != Readline::HISTORY[i+1]
        rescue IndexError
        end
    }
    Readline::HISTORY.clear
    no_dups.each { |e|
        Readline::HISTORY.push e
    }
}

def history_a(n=Readline::HISTORY.size)
    size=Readline::HISTORY.size
    Readline::HISTORY.to_a[(size - n)..size-1]
end

def decorate_h(n)
    size=Readline::HISTORY.size
    ((size - n)..size-1).zip(history_a(n)).map {|e| e.join(" ")}
end

def h(n=10)
    entries = decorate_h(n)
    puts entries
    entries.size
end

def hgrep(word)
    matched=decorate_h(Readline::HISTORY.size - 1).select {|h| h.match(word)}
    puts matched
    matched.size
end

def h!(start, stop=nil)
    stop=start unless stop
    code = history_a[start..stop]
    code.each_with_index { |e,i|
        irb_context.evaluate(e,i)
    }   
    Readline::HISTORY.pop
    code.each { |l| 
        Readline::HISTORY.push l
    }   
    puts code
end



class Object
  def my_methods
    (self.methods - Object.methods).sort
  end
end

