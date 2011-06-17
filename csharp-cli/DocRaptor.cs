using System;
using System.IO;
using System.Text;
using System.Net;
using System.Web;

namespace DocRaptorConsoleExample {
    class DocRaptor {
        private const string PostFormat = "doc[{0}]={1}&doc[name]={2}&doc[document_type]={3}&doc[test]={4}";
        private const string ApiKey = @"YOUR API KEY HERE";
        private static string DocRaptorUrl = String.Format("https://docraptor.com/docs?user_credentials={0}", ApiKey);

        public string DocumentContent { get; set; }
        public string DocumentURL { get; set; }
        public string Name { get; set; }
        public bool Test { get; set; }

        public bool CreateDocument(string type) {
            if (string.IsNullOrEmpty(DocumentContent) && string.IsNullOrEmpty(DocumentURL)) {
                Console.WriteLine("Please specify either DocumentContent or DocumentURL");
                return false;
            }

            string postData = String.Format(PostFormat,
                (string.IsNullOrEmpty(DocumentContent) ? "document_url" : "document_content"),
                HttpUtility.UrlEncode(string.IsNullOrEmpty(DocumentContent) ? DocumentURL : DocumentContent),
                HttpUtility.UrlEncode(Name),
                HttpUtility.UrlEncode(type),
                HttpUtility.UrlEncode(Test.ToString().ToLower()));
            var byteArray = Encoding.UTF8.GetBytes(postData);

            var request = (HttpWebRequest)WebRequest.Create(DocRaptorUrl);
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = byteArray.Length;
            using (var dataStream = request.GetRequestStream()) { dataStream.Write(byteArray, 0, byteArray.Length); }

            try {
                var response = request.GetResponse();
                using (var dataStream = response.GetResponseStream()) {
                    using (Stream file = File.OpenWrite(Name)) { CopyStream(dataStream, file); }
                }
                Console.WriteLine("File Saved");
                return true;
            } catch (WebException e) {
                if (e.Status == WebExceptionStatus.ProtocolError) {
                    var response = (HttpWebResponse)e.Response;
                    string errorResponse;
                    using (var dataStream = response.GetResponseStream()) {
                        using (var reader = new StreamReader(dataStream)) { errorResponse = reader.ReadToEnd(); }
                    }
                    Console.WriteLine(errorResponse);
                    Console.WriteLine(string.Format("{0} - {1}", response.StatusCode, response.StatusDescription));
                } else {
                    Console.WriteLine(e.Message);
                }
            }
            return false;
        }

        public static void CopyStream(Stream input, Stream output) {
            var buffer = new byte[8 * 1024];
            int len;
            while ((len = input.Read(buffer, 0, buffer.Length)) > 0) { output.Write(buffer, 0, len); }
        }

        public bool CreatePDF() {
            return this.CreateDocument("pdf");
        }

        public bool CreateXLS() {
            return this.CreateDocument("xls");
        }

        static void Main(string[] args) {
            /*** PDF Example ***/
            DocRaptor doc_raptor = new DocRaptor() {
                DocumentContent = @"<html><body>This is a DocRaptor example!</body></html>",
                Name = "csharp_sample.pdf",
                Test = true
            };

            doc_raptor.CreatePDF();

            /*** Excel Example ***/
            /*DocRaptor doc_raptor = new DocRaptor() {
                DocumentContent = @"<table name="Test Sheet"><tr><td>I am a cell!</td></tr></table>",
                Name = "csharp_sample.xls",
                Test = true
            };

            doc_raptor.CreateXLS(); */
        }
    }
}
