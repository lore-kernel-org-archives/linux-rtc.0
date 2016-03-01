Return-Path: <rtc-linux+bncBCC6ZWOPXENRBZNE2W3AKGQEOOPNNGI@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id h73si549545wme.0.2016.03.01.00.27.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Mar 2016 00:27:16 -0800 (PST)
From: Juergen Borleis <jbe@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] Re: [PATCH] rtc: pcf85063: remove useless century handling
Date: Tue, 1 Mar 2016 09:29:19 +0100
Cc: rtc-linux@googlegroups.com,
 Alessandro Zummo <a.zummo@towertech.it>,
 linux-kernel@vger.kernel.org,
 Ulrich =?iso-8859-15?q?=D6lmann?= <u.oelmann@pengutronix.de>
References: <1456268728-343-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1456268728-343-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201603010929.19210.jbe@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wednesday 24 February 2016 00:05:28 Alexandre Belloni wrote:
> pcf85063_get_datetime() tries to handle a century bit but that bit is not
> documented and the final value is never used anywhere else in the kernel.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/rtc/rtc-pcf85063.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> index c5db231f14de..2b3b99b094b5 100644
> --- a/drivers/rtc/rtc-pcf85063.c
> +++ b/drivers/rtc/rtc-pcf85063.c
> @@ -31,13 +31,10 @@
>  #define PCF85063_REG_MO			0x09
>  #define PCF85063_REG_YR			0x0A
>
> -#define PCF85063_MO_C			0x80 /* century */
> -
>  static struct i2c_driver pcf85063_driver;
>
>  struct pcf85063 {
>  	struct rtc_device *rtc;
> -	int c_polarity;	/* 0: MO_C=3D1 means 19xx, otherwise MO_C=3D1 means 20x=
x */
>  	int voltage_low; /* indicates if a low_voltage was detected */
>  };
>
> @@ -103,9 +100,6 @@ static int pcf85063_get_datetime(struct i2c_client
> *client, struct rtc_time *tm) tm->tm_year =3D bcd2bin(regs[6]);
>  	if (tm->tm_year < 70)
>  		tm->tm_year +=3D 100;	/* assume we are in 1970...2069 */
> -	/* detect the polarity heuristically. see note above. */
> -	pcf85063->c_polarity =3D (regs[5] & PCF85063_MO_C) ?
> -		(tm->tm_year >=3D 100) : (tm->tm_year < 100);
>
>  	return rtc_valid_tm(tm);
>  }

Reviewed-by: Juergen Borleis <jbe@pengutronix.de>
Tested-by: Ulrich =D6lmann <u.oelmann@pengutronix.de>

Regards,
Juergen
