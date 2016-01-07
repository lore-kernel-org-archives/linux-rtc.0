Return-Path: <rtc-linux+bncBCC6ZWOPXENRBTPTXC2AKGQENXRER5I@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id d185si328293wmf.0.2016.01.07.02.11.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 07 Jan 2016 02:11:24 -0800 (PST)
From: Juergen Borleis <jbe@pengutronix.de>
To: kernel@pengutronix.de
Subject: [rtc-linux] Re: [PATCH 2/3] RTC/PCF85063: fix time/date reading (part II)
Date: Thu, 7 Jan 2016 11:12:52 +0100
Cc: rtc-linux@googlegroups.com,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-kernel@vger.kernel.org
References: <1449496174-7813-1-git-send-email-jbe@pengutronix.de> <1449496174-7813-3-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1449496174-7813-3-git-send-email-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201601071112.52284.jbe@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

(please keep me on CC...)

> [...]
> > -	/* read registers */
> > -	if ((i2c_transfer(client->adapter, msgs, 2)) !=3D 2) {
> > -		dev_err(&client->dev, "%s: read error\n", __func__);
> > -		return -EIO;
>
> Isn't that already reading the time and date register in one block? I'd
> say you are simply reading less registers. Also, maybe you could use
> i2c_smbus_read_block_data?

Its just a "try" to make the code more readable, by a named subfunction and=
=20
more comments why things must happen that way.
Will check for the suggested smbus function.

Regards,
Juergen

=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Borleis =A0 =A0 =A0 =A0 =A0 =A0 |
Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| http://=
www.pengutronix.de/ =A0|
