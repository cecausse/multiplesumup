# Multiplesumup
This project was used in a real-life setting.   
It was designed for a particular case and should be adapted to your own needs.   
It was designed on my own time on July 2021.

Problem: Several vendors are on the same site in a shopping center.   
They take turns every day and have to manage the sales of themselves and of the other vendors.   
They all use the Sumup payment terminal.

## Solutions
There were 3 solutions:
- either the sellers had to have the password and login for each salesman, and had to log in/log out again each time.
- or each seller had to buy the more expensive standalone version of Sumup, and had to change between each sale
- or someone developed an application that played with the Sumup API

So I developed a flutter application, linked to a Firebase database, which lists the different vendors.   
This application is connected to a single Sumup terminal.

When a seller makes a sale, he just has to click on the seller and the application connects directly to the Sumup, to the right seller.
Some manipulations on Sumup are to be done for each seller to transform the account into a developer account

Many, many improvements can be made, I designed it in a short time as a last resort before vendors purchase the standalone payment terminal, for each vendor.