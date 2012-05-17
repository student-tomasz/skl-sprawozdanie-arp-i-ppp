require_relative 'util/pdfreader'
require_relative 'util/ext' #here be monkeypatching

$document = Dir.glob('*.tex').first.ext('pdf')
$dependencies = [] + Dir.glob('**/*.tex') + Dir.glob('./*sty')
$byproducts = "*.out *.log *.aux *.toc"

$lc = 'xelatex'
$lf = '-interaction=nonstopmode'

file $document => [$document.ext('tex'), *$dependencies] do |t|
  2.times { sh "#{$lc} #{$lf} #{t.prerequisites[0]} > /dev/null" }
end

task :default => :build

task :build => $document

task :show => $document do
  PDFReaderCommand.find.run($document)
end

task :clean do
  sh "rm -f #{$byproducts}"
end

# Wypisuje slowa ktore nie wystepuja w polskim ani angielskim
# slowniku, kazde slowo tylko raz, pomija listingi.
task :spell do
  $dependencies.each do |file|
    next unless file =~ /\.tex$/
    puts "  #{file}  ".center(80, "#")
    system "sed '/begin{lstlisting}/,/end{lstlisting}/d' #{file} |" +
      " aspell list -a -t -l pl | aspell list -a | sort | uniq"
  end
end
