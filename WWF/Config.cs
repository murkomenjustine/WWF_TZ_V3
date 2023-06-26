﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Web;

namespace WWF
{
    public class Config
    {
        public Nav.NAV ReturnNav()
        {

            Nav.NAV nav = new Nav.NAV(new Uri(ConfigurationManager.AppSettings["ODATA_URI"]))
            {
                Credentials =
                    new NetworkCredential(ConfigurationManager.AppSettings["W_USER"],
                        ConfigurationManager.AppSettings["W_PWD"], ConfigurationManager.AppSettings["DOMAIN"])
            };
            return nav;
        }

        public static eprocurement.eprocurement ObjNav
        {
            get
            {
                var ws = new eprocurement.eprocurement();

                try
                {
                    var credentials = new NetworkCredential(ConfigurationManager.AppSettings["W_USER"],
                        ConfigurationManager.AppSettings["W_PWD"], ConfigurationManager.AppSettings["DOMAIN"]);
                    ws.Credentials = credentials;
                    ws.PreAuthenticate = true;

                }
                catch (Exception ex)
                {
                    ex.Data.Clear();
                }
                return ws;
            }
        }

        public static NaExtender.NavXtenderAddLink navExtender
        {
            get
            {
                var res = new NaExtender.NavXtenderAddLink();
                try
                {
                    var credential = new NetworkCredential(ConfigurationManager.AppSettings["W_USER"],
                        ConfigurationManager.AppSettings["W_PWD"], ConfigurationManager.AppSettings["DOMAIN"]);
                    res.Credentials = credential;
                    res.PreAuthenticate = true;

                }
                catch (Exception ex)
                {

                    ex.Data.Clear();
                }

                return res;
            }
        }

        public Boolean IsAllowedExtension(String extension)
        {
            Boolean check = Convert.ToBoolean(ConfigurationManager.AppSettings["CheckFileExtensions"]);
            if (check)
            {
                String allowedFileTypes = ConfigurationManager.AppSettings["AllowedFileExtensions"];
                String[] info = allowedFileTypes.Split(',');
                extension = extension.Replace('.', ' ');
                extension = extension.Trim();
                extension = extension.ToLower();
                foreach (String fileExtension in info)
                {
                    String myExtension = fileExtension;
                    myExtension = myExtension.Replace('.', ' ');
                    myExtension = myExtension.Trim();
                    myExtension = myExtension.ToLower();
                    if (myExtension == extension)
                    {
                        return true;
                    }
                }

            }
            else
            {
                return true;
            }
            return false;
        }

        public static string FilesLocation() => ConfigurationManager.AppSettings[nameof(FilesLocation)];
    }
}