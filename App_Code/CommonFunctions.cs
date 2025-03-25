using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.IO.Compression;
using System.Configuration;
using System.Net.Mail;
using System.Net;
using System.Web.Services.Description;
using System.Web.UI;
using System.Drawing;
using System.Web.UI.WebControls;

namespace eCerpac_NIS.App_Code
{
    public class CommonFunctions
    {
        public static string connection = System.Configuration.ConfigurationManager.ConnectionStrings["con_eCERPAC"].ToString();
       

        public static DataTable fetchdata(string query)
        {
            SqlConnection con = new SqlConnection(connection);
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            con.Dispose();
            return dt;
        }

        public static int insertupdateordelete(string query)
        {
            SqlConnection con = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int status = cmd.ExecuteNonQuery();
            con.Close();
            return status;
        }



        public static string ConvertToDateStringFormat(object dateValue)
        {
            DateTime parsedDate;
            if (dateValue is DateTime)
            {
                parsedDate = (DateTime)dateValue;
            }
            else if (dateValue is string && DateTime.TryParse((string)dateValue, out parsedDate))
            {
            }
            else
            {
                return string.Empty;
            }
            return parsedDate.ToString("yyyy-MM-dd");
        }


        public static int SendMail(string lblCerpacNo, string lblPassport_No, string lblComment, string lblFormNo, string Opt)
        {
            //-------------------Configuration settings details-------------------      

            //string sender = ConfigurationManager.AppSettings["userName"].ToString();
            //string senderPassword = ConfigurationManager.AppSettings["password"].ToString();
            //string senderHost = ConfigurationManager.AppSettings["host"].ToString();
            //int senderPort = Convert.ToInt16(ConfigurationManager.AppSettings["port"]);
            //Boolean isSSL = Convert.ToBoolean(ConfigurationManager.AppSettings["enableSsl"]);

            ////-------------------Get Applicant details-------------------      
            //string Email = "", txtName = "";
            //string qry = "SELECT Title,people_id ,tile1,forename,middle_name,surname,sex,cerpac_no,cerpac_file_no,cerpac_receipt_date , picture    ,cerpac_expiry_date,registration_area,registration_code,file_no,passport_no,nationality,passport_issue_date,passport_expiry_date " +
            //                   ",passport_issue_loc,passport_issue_by,date_of_birth,place_of_birth,nigeria_add_1,nigeria_add_2,nigeria_tel_no,abroad_add_1     ,abroad_add_2,abroad_tel_no,company,company_add_1,company_add_2,designation,employment_date,company_tel_no,company_fax_no " +
            //                   ",email,verid_template,ContactNo,userImage,IsVerified,IsAuthorized,IsProduced,VerifiedBy,AuthorizedBy,ProducedBy     ,ProducedOn,AuthorizedOn,VerifiedOn,IsRejected,RejectedBy,RejectedOn,RejectionReason,ZoneNote,AuthNote,ProdNote,QualNote " +
            //                   ",IsDependent,DesignationCode,DependentOn,ISARCR,ConfirmedBy,ConfirmedOn,Cerpac_ExpiryDt,Cerpac_IssuedDt,IsQual,QualBy,QualOn,CompanyName    ,date_system_modified ,  EducationLevel,InstitutionName, IsCompleted,DegreeCompletedOn " +
            //                   " FROM vw_ApplicantDetails where cerpac_no='" + lblCerpacNo.ToString().Trim() + "' and cerpac_file_no='"+ lblFormNo.ToString().Trim() + "'";


            //DataTable dt = new DataTable();
            //dt = fetchdata(qry);

            //if (dt.Rows.Count > 0)
            //{
            //    txtName = dt.Rows[0]["Title"].ToString() + " " + dt.Rows[0]["forename"].ToString() + " " + dt.Rows[0]["surname"].ToString();
            //    // Email = dt.Rows[0]["email"].ToString();
            //    Email = "amitsinghus@yahoo.com";
            //    //-------------------Get Mail Formate details-------------------      
            //    string body = string.Empty;

            //    // qry = "Select Subject, Title, Header, Body, Footer ,Opt from tbl_MailTempMaster W, tbl_FormMaster F where W.FormID = F.FormID and  F.formurl = '~/" + frmName.ToString() + "' and W.Opt='" + Opt.ToString() + "' ";
            //    // DataTable dtM = new DataTable();
            //    // dtM = fetchdata(qry);
            //    // if (dtM.Rows.Count > 0)
            //    int i = 0;
            //   if( i == 0)
            //    {


            //        //---------Read Teamplate and Pass data to teamplate string-------------
            //        //using streamreader for reading my htmltemplate   

            //        using (StreamReader reader = new StreamReader(HttpContext.Current.Server.MapPath("~/WebTemplate.html")))
            //        {
            //            {
            //                body = reader.ReadToEnd();
            //            }
            //            body = body.Replace("{UserName}", txtName); //replacing the required things  
            //            body = body.Replace("{Title}", "Nigrian Immgration Service");
            //            body = body.Replace("{Header}", "eCERPAC");
            //            body = body.Replace("{Body}", "Card Issued");
            //            body = body.Replace("{message}", lblComment);
            //            body = body.Replace("{footer}", "Regards");
            //        }

            //    }
            //    string subject = "Hello, Aplicant";

            //    //------------------Configure the Email Body----------------------------
            //    MailMessage msg = new MailMessage();
            //    msg.IsBodyHtml = true;
            //    msg.From = new MailAddress(sender);
            //    msg.To.Add(Email.ToString());
            //    msg.Subject = subject;
            //    msg.Body = body;
            
            //     msg.Attachments.Add(new Attachment(new MemoryStream(bytes), "name.png"));

            //    //---------------- Create a SMTP server to send the email -------------------
            //    SmtpClient smtpServer = new SmtpClient();
            //    smtpServer.Host = senderHost;
            //    smtpServer.Port = senderPort;
            //    smtpServer.EnableSsl = isSSL;

            //    //------------------Passing the credentials of the user---------------------
            //    smtpServer.DeliveryMethod = SmtpDeliveryMethod.Network;
            //    NetworkCredential credentials = new NetworkCredential(sender, senderPassword);
            //    smtpServer.Credentials = credentials;
            //    smtpServer.Send(msg);
            //    return 1;
            //}

            return 0;
        }



        //----------------------------------------base 64 encode and decoding functions----------------------------

        public static string base64Decode(string data)
        {
            try
            {
                System.Text.UTF8Encoding encoder = new System.Text.UTF8Encoding();
                System.Text.Decoder utf8Decode = encoder.GetDecoder();

                byte[] todecode_byte = Convert.FromBase64String(data);
                int charCount = utf8Decode.GetCharCount(todecode_byte, 0, todecode_byte.Length);
                char[] decoded_char = new char[charCount];
                utf8Decode.GetChars(todecode_byte, 0, todecode_byte.Length, decoded_char, 0);
                string result = new String(decoded_char);
                return result;
            }
            catch (Exception e)
            {
                throw new Exception("Error in base64Decode" + e.Message);
            }
        }
        public static string base64Encode(string data)
        {
            try
            {
                byte[] encData_byte = new byte[data.Length];
                encData_byte = System.Text.Encoding.UTF8.GetBytes(data);
                string encodedData = Convert.ToBase64String(encData_byte);
                return encodedData;
            }
            catch (Exception e)
            {
                throw new Exception("Error in base64Encode" + e.Message);
            }
        }
        //----------------------------------------end -------------------------------------------------------

        //---------------------Login Audit trail-------------------------
        public static string LoginAudit(string MachineIP, string MachingName, string WindowUser, string AuditDetail, string AuditType, string UserID)
        {
            SqlConnection con = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand();

            cmd.Connection = con;
            cmd.CommandText = "UspAuditTransInsert";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@AuditType", AuditType.ToString().Trim());
            cmd.Parameters.AddWithValue("@UserId", UserID.ToString().Trim());
            cmd.Parameters.AddWithValue("@AuditDetail", AuditDetail.ToString().Trim());
            cmd.Parameters.AddWithValue("@MachineIP", MachineIP.ToString().Trim());
            cmd.Parameters.AddWithValue("@MachineName", MachingName.ToString().Trim());
            cmd.Parameters.AddWithValue("@WindowUser", WindowUser.ToString().Trim());           
            SqlParameter output = new SqlParameter("@SuccessId", SqlDbType.Int);
            output.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(output);
            con.Open();
            cmd.ExecuteNonQuery();
            String R = output.Value.ToString();
            con.Close();


            if (R != String.Empty)
                return R;
            else
                return "X";



        }




    }
}