﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="WebApplication1.Home"  %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SearchView - TechStore</title>
    <link id="pagestyle" href="lib/material/css/material-dashboard.css?v=3.0.4" rel="stylesheet" />
    <link rel="stylesheet" href="css/site.css" asp-append-version="true" />
    <link rel="stylesheet" href="/WebApplication.styles.css" asp-append-version="true" />
    <link href="lib/material/css/nucleo-icons.css" rel="stylesheet" />
    <link href="lib/material/css/nucleo-svg.css" rel="stylesheet" />
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/@dotlottie/player-component@latest/dist/dotlottie-player.mjs" type="module"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
</head>
<body>
    <header id="header" class="container position-sticky z-index-sticky "><br /><br /><br />
        <div class="row">
            <div class="col-12">
                <!-- Navbar -->
                <nav class="navbar navbar-expand-lg blur border-radius-xl top-0 z-index-3 shadow position-absolute my-3 py-2 start-0 end-0 mx-4">
                    <div class="container-fluid ps-2 pe-0">
                        <a class="navbar-brand font-weight-bolder ms-lg-0 ms-3 " href="/Home">
                            TechStore
                        </a>
                        <button class="navbar-toggler shadow-none ms-2" type="button" data-bs-toggle="collapse" data-bs-target="#navigation" aria-controls="navigation" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon mt-2">
                                <span class="navbar-toggler-bar bar1"></span>
                                <span class="navbar-toggler-bar bar2"></span>
                                <span class="navbar-toggler-bar bar3"></span>
                            </span>
                        </button>
                        <div class="collapse navbar-collapse" id="navigation">
                            <ul class="navbar-nav mx-auto">
                                <li class="nav-item">
                                    <a class="nav-link d-flex align-items-center me-2 active" aria-current="page" href="/Cart">
                                        <i class="fa fa-shopping-cart opacity-6 text-dark me-1"></i>
                                        Cart
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link me-2" href="/Profile">
                                        <i class="fa fa-user opacity-6 text-dark me-1"></i>
                                        Profile
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link me-2" href="/History">
                                        <i class="fa fa-history opacity-6 text-dark me-1"></i>
                                        History
                                    </a>
                                </li>
                                <li id="login" class="nav-item">
                                    <a class="nav-link me-2" href="/Login">
                                        <i class="fas fa-sign-in opacity-6 text-dark me-1"></i>
                                        Sign In
                                    </a>
                                </li>
                                <!--<li class="nav-item">
                                    <a class="nav-link me-2" href="/About">
                                        <i class="fas fa-info opacity-6 text-dark me-1"></i>
                                        About us
                                    </a>
                                </li>-->
                                <li class="nav-item">
                                    <a class="nav-link me-2" href="/Logout">
                                        <i class="fas fa-times-circle opacity-6 text-dark me-1"></i>
                                        Sign Out
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <form method="get">
                                        <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
                                            <div class="ms-md-auto pe-md-3 d-flex align-items-center">
                                                <div class="input-group input-group-outline">
                                                    <!-- <label class="form-label">Type here...</label> -->
                                                    <input name="p" type="text" placeholder="Search" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <!-- End Navbar -->
            </div>
        </div>
    </header>
    <div class="container">
        <main role="main" class="pb-3">
    <%
        var coookie = "";
        try
        {
            coookie = Request.Cookies["role"].ToString();
        }catch(Exception ex)
        {
            
        }

        if (coookie != null && coookie.Length > 0)
        {
            if (coookie == "0")
            {
                Response.Redirect("/Dashboard");
            }
        }

        WebApplication1.Config config = new WebApplication1.Config();
        SqlConnection conn = new SqlConnection(config.dbConnection);
        string item = Request.QueryString["p"];
        string query;
        query = $"select * from Items";



%>

<div class="container-fluid py-4">
            <div class="row mt-auto">
                <% 
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(query, conn);
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (!rdr.HasRows)
                    {
                %>
                    <div>
                        <dotlottie-player src="https://lottie.host/69d0c8ae-103a-4a57-aaf4-d1374d005b2d/87ciEZiWSi.json" background="transparent" speed="1" style="width: 500px; height: 500px" direction="1" mode="normal" loop autoplay></dotlottie-player>
                        <div class="alert alert-secondary text-white">No items available at the moment! Try again later.</div>
                    </div>
                <%
                    }
                    else
                    {
                        while (rdr.Read())
                        {
                            if (rdr["name"].ToString().ToLower().Contains(item.ToLower()))
                            {
                             %>
                                <div class="col-lg-4 col-md-6 mt-4 mb-4">
                                    <a href="/Product?id=<%= rdr["id"] %>" class="card z-index-2">
                                        <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2 bg-transparent">
                                            <div class="bg-gradient-secondary shadow-success border-radius-lg py-3 pe-1">
                                                <div class="text-center">
                                                    <img src="/img/<%= rdr["image"] %>" width="315" height="215" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h6 class="mb-0"><%= rdr["name"] %></h6>
                                            <p class="text-sm"><%= rdr["description"] %></p>
                                            <hr class="dark horizontal">
                                            <div class="d-flex">
                                                <i class="material-icons text-sm my-auto me-1">attach_money</i>
                                                <p class="mb-0 text-sm"><%= rdr["price"] %></p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                             <%
                            }
                        }
                    }
                    rdr.Close();
                    conn.Close();
                %>
            </div>
        </div>

        </main>
    </div>
    <footer  class="footer position-absolute bottom-2 py-2 w-100" >
        <div id="footer" class="container">
            <div class="row align-items-center justify-content-lg-between">
                <div class="col-12 col-md-6 my-auto">
                    <div class="copyright text-center text-sm  text-lg-start">
                        © <script>
                              document.write(new Date().getFullYear()) 
                        </script>,
                        made with <i class="fa fa-heart" aria-hidden="true"></i> by
                        <a href="https://techstore.com" target="_blank" class="font-weight-bold ">TechStore</a>
                        for a better web.
                    </div>
                </div>
                <div class="col-12 col-md-6">
                    <ul class="nav nav-footer justify-content-center justify-content-lg-end">
                        <li class="nav-item">
                            <a class="nav-link " href="/About">About Us</a>
                        </li>
                        <li class="nav-item">
                            <a href="mailto: support@TechStore.com"  class="nav-link " >Support</a>
                        </li>
                        <li class="nav-item" >
                            <a href="/Logout" class="nav-link pe-0 ">Log Out</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>

    <script>

        let role = getCookie("role");
        if (role != "") {
            var login = document.getElementById("login")
            login.style.display = "none"
            var footer = document.getElementById("footer")
            var header = document.getElementById("header")
            if(role != "0"){
                header.style.display = "block"
                footer.style.display = "block"
            }
        }

        function getCookie(cname) {
            let name = cname + "=";
            let ca = document.cookie.split(';');
            for (let i = 0; i < ca.length; i++) {
                let c = ca[i];
                while (c.charAt(0) == ' ') {
                    c = c.substring(1);
                }
                if (c.indexOf(name) == 0) {
                    return c.substring(name.length, c.length);
                }
            }
            return "";
        }
    </script>

    <script src="/lib/jquery/dist/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    <script src="/lib/material/js/material-dashboard.min.js?v=3.0.4"></script>
    <script src="/js/site.js" asp-append-version="true"></script>
    <script src="/js/lottie.js"></script>
</body>
</html>
