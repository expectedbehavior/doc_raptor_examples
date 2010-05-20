using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Windows;
using Microsoft.Win32;

namespace DocRaptorExample
{
  /// <summary>
  /// Interaction logic for MainWindow.xaml
  /// </summary>
  public partial class MainWindow : Window
  {
    private const string PostFormat = "doc[document_content]={0}&doc[name]={1}&doc[document_type]={2}&doc[test]={3}";
    private const string ApiKey = "YOUR_API_KEY_HERE";
    private static string DocRaptorUrl = String.Format("https://docraptor.com/docs?user_credentials={0}", ApiKey);

    public MainWindow()
    {
      InitializeComponent();
      SampleExcelContentClick(null, null);
    }

    private void SampleExcelContentClick(object sender, RoutedEventArgs e)
    { _DocumentContent.Text = "<table name='My First Sheet'>\n  <tr>\n    <td>Cell 1</td>\n    <td>Cell 2</td>\n  </tr>\n</table>"; }

    private void SamplePDFContentClick(object sender, RoutedEventArgs e)
    { _DocumentContent.Text = "<html>\n  <body>\n    Some Text in a PDF\n  </body>\n</html>"; }

    private void CreateExcelClick(object sender, RoutedEventArgs e)
    { CreateDocument(_DocumentContent.Text, "xls", true); }

    private void CreatePDFClick(object sender, RoutedEventArgs e)
    { CreateDocument(_DocumentContent.Text, "pdf", true); }

    public static void CreateDocument(string documentContent, string type, bool test)
    {
      var sfd = new SaveFileDialog();
      if (sfd.ShowDialog() != true) { return; }

      var postData = String.Format(PostFormat, HttpUtility.UrlEncode(documentContent), HttpUtility.UrlEncode(sfd.SafeFileName),
          HttpUtility.UrlEncode(type), HttpUtility.UrlEncode(test.ToString()));
      var byteArray = Encoding.UTF8.GetBytes(postData);

      var request = (HttpWebRequest)WebRequest.Create(DocRaptorUrl);
      request.Method = "POST";
      request.ContentType = "application/x-www-form-urlencoded";
      request.ContentLength = byteArray.Length;
      using (var dataStream = request.GetRequestStream())
      { dataStream.Write(byteArray, 0, byteArray.Length); }

      try
      {
        var response = request.GetResponse();
        using (var dataStream = response.GetResponseStream())
        {
          using (Stream file = File.OpenWrite(sfd.FileName))
          { CopyStream(dataStream, file); }
        }
        MessageBox.Show("File Saved", "Success");
      }
      catch (WebException e)
      {
        if (e.Status == WebExceptionStatus.ProtocolError)
        {
          var response = (HttpWebResponse)e.Response;
          string errorResponse;
          using (var dataStream = response.GetResponseStream())
          {
            using (var reader = new StreamReader(dataStream))
            { errorResponse = reader.ReadToEnd(); }
          }
          MessageBox.Show(errorResponse, String.Format("{0} - {1}", response.StatusCode, response.StatusDescription));
        }
        else
        {
          MessageBox.Show(e.Message, "Error");
        }
      }
    }

    public static void CopyStream(Stream input, Stream output)
    {
      var buffer = new byte[8 * 1024];
      int len;
      while ((len = input.Read(buffer, 0, buffer.Length)) > 0)
      { output.Write(buffer, 0, len); }
    }

    private void OpenLinkClick(object sender, RoutedEventArgs e)
    { System.Diagnostics.Process.Start(((System.Windows.Documents.Hyperlink)sender).NavigateUri.ToString()); }
  }
}
