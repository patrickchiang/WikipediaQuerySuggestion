using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Auth;
using Microsoft.WindowsAzure.Storage.Blob;
using Microsoft.WindowsAzure;
using System.Text.RegularExpressions;
using System.Diagnostics;

namespace QuerySuggestion
{
    [WebService(Namespace = "http://info344qs.azurewebsites.net")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class queries : System.Web.Services.WebService
    {
        static Trie trie;
        static Boolean buildLock = false;

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void query(string data)
        {
            //string json = new JavaScriptSerializer().Serialize("Hello World " + data);

            if (trie == null)
            {
                HttpContext.Current.Response.Write("Trie has not yet been built. Wait a few seconds.");
                if (!buildLock)
                {
                    buildDictionary();
                }
            }
            else
            {
                if (buildLock)
                {
                    HttpContext.Current.Response.Write("Trie has not finished building. Wait a few seconds.");
                    return;
                }

                List<string> results = trie.Search(data);
                if (results == null)
                {
                    HttpContext.Current.Response.Write("Term not found.");
                }
                else
                {
                    for (int i = 0; i < results.Count; i++)
                    {
                        results[i] = results[i].Substring(1);
                    }

                    var jsonSerialiser = new JavaScriptSerializer();
                    var json = jsonSerialiser.Serialize(results);

                    HttpContext.Current.Response.Write(json);
                }
            }
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void buildDictionary()
        {
            buildLock = true;
            trie = new Trie();

            // Cloud setup
            CloudStorageAccount storageAccount = CloudStorageAccount.Parse(CloudConfigurationManager.GetSetting("StorageConnectionString"));
            CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
            CloudBlobContainer container = blobClient.GetContainerReference("support");
            CloudBlockBlob blockBlob = container.GetBlockBlobReference("newtitles.txt");

            PerformanceCounter ramCounter = new PerformanceCounter("Memory", "Available MBytes");

            // Loop through stream
            using (var stream = blockBlob.OpenRead())
            {
                using (StreamReader reader = new StreamReader(stream))
                {
                    for (int i = 0; !reader.EndOfStream; i++)
                    {
                        string line = reader.ReadLine();
                        if (new Regex(@"^[a-zA-Z _]+$").Match(line).Success)
                        {
                            trie.Add(line);
                        }

                        if (i % 10000 == 0)
                        {
                            HttpContext.Current.Response.Write(ramCounter.RawValue);
                            if (ramCounter.RawValue <= 40)
                            {
                                break;
                            }
                        }
                    }

                }
            }

            buildLock = false;
        }
    }
}
