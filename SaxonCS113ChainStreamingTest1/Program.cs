using Saxon.Api;

namespace SaxonCS113ChainStreamingTest1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Uri baseUri = new Uri(Path.Combine(Environment.CurrentDirectory, "result.xml"));

            Processor processor = new();

            var xsltCompiler = processor.NewXsltCompiler();

            var childrenToAttributesExecutable = xsltCompiler.Compile(new Uri(baseUri, "child-elements-to-attributes.xsl"));

            var childrenToAttributesTransformer = childrenToAttributesExecutable.Load30();

            var groupingExecutable = xsltCompiler.Compile(new Uri(baseUri, "streamed-grouping.xsl"));

            var groupingTransformer = groupingExecutable.Load30();

            using (var fs = File.OpenRead("items-with-child-elements.xml"))
            {
                childrenToAttributesTransformer.ApplyTemplates(fs, baseUri, groupingTransformer.AsDocumentDestination(processor.NewSerializer(Console.Out)));
            }
        }
    }
}