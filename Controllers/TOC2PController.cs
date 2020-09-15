using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using System.Data;
using System.Text.RegularExpressions;
using _2C2P_TEST.Models;
using System.Text;


namespace _2C2P_TEST.Controllers
{
    public class TOC2PController : Controller
    {
        // GET: TOC2P
        private Entities DB = new Entities();
        public ActionResult Index()
        {
            return View();
        }

        public static string[] SplitCsv(string line)
        {
            List<string> result = new List<string>();
            StringBuilder currentStr = new StringBuilder("");
            bool inQuotes = false;
            for (int i = 0; i < line.Length; i++) // For each character
            {
                if (line[i] == '\"') // Quotes are closing or opening
                    inQuotes = !inQuotes;
                else if (line[i] == ',') // Comma
                {
                    if (!inQuotes) // If not in quotes, end of current string, add it to result
                    {
                        result.Add(currentStr.ToString());
                        currentStr.Clear();
                    }
                    else
                        currentStr.Append(line[i]); // If in quotes, just add it 
                }
                else // Add any other character to current string
                    currentStr.Append(line[i]);
            }
            result.Add(currentStr.ToString());
            return result.ToArray(); // Return array of all strings
        }

        
        protected bool CheckValidColumn(string filePath)
        {
            StreamReader sr = new StreamReader(filePath);
            while (!sr.EndOfStream)
            {
                string[] rows = Regex.Split(sr.ReadLine(), ",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)");
                if (rows.Count() < 5) return false;
            }
            return true;

        }

        protected DataTable ReadCSVfile(string filePath)
        {
            StreamReader sr = new StreamReader(filePath);
            DataTable dt = new DataTable();
            string[] Headers = Regex.Split(sr.ReadLine(), ",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)");
            for (int i = 0; i < Headers.Length; i++)
            {
                string colName = "col" + i.ToString();
                dt.Columns.Add(colName);
            }
            
            while (!sr.EndOfStream)
            {
                string[] rows = Regex.Split(sr.ReadLine(), ",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)");
                DataRow dr = dt.NewRow();
                for (int i = 0; i < rows.Length; i++)
                {
                    string colName = "col" + i.ToString();
                    dr[colName] = rows[i].Replace("\"", "");
                }
                dt.Rows.Add(dr);
            }
            return dt;

        }

        protected bool AddCSVtoDB(string pathFile)
        {
            try
            {
                DataTable dtCSV = ReadCSVfile(pathFile);
                TBL_TransactionDATA TRDATA = new TBL_TransactionDATA();
                foreach (DataRow item in dtCSV.Rows)
                {
                    string STATUS = string.Empty;
                    TRDATA.TRNID = item[0].ToString();
                    TRDATA.AMOUNT = Convert.ToInt32(item[1].ToString());
                    TRDATA.CURRENCY = item[2].ToString();
                    TRDATA.TRANDATE = item[3].ToString();
                    if (item[4].ToString().Equals("Approved")) { STATUS = "A"; }
                    else if (item[4].ToString().Equals("Failed")) { STATUS = "R"; }
                    else if (item[4].ToString().Equals("Finished")) { STATUS = "D"; }
                    TRDATA.STATUS = STATUS;
                    DB.TBL_TransactionDATA.Add(TRDATA);
                    DB.SaveChanges();
                }
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }

        }

        [HttpPost]
        public ActionResult Index(HttpPostedFileBase file)
        {
            //int statuscode = 0;
            string path = Path.Combine(Server.MapPath("~/Uploadfile"),
                                               Path.GetFileName(file.FileName));
            string extension = Path.GetExtension(file.FileName);
            file.SaveAs(path);
            if (extension.Contains("csv") || extension.Contains("xml"))
            {
                switch (extension)
                {
                    case ".csv":
                        if (CheckValidColumn(path))
                        {
                            if (AddCSVtoDB(path))
                            {
                                ViewBag.Message = 200;
                            }
                        }
                        else
                        {
                            ViewBag.Message = 400;
                        }
                        break;
                    case ".xml": break;
                    default:
                        break;
                }
            }
            else
            {
                //return HttpNotFound("Unknow format");
                ViewBag.Message = "Unknow format";
            }
            return View();
        }
    }
}