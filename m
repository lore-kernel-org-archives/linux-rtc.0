Return-Path: <rtc-linux+bncBCC6ZWOPXENRB7HCYC3AKGQEFNX6EFY@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id s141si138175wmd.1.2016.02.26.03.05.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Feb 2016 03:05:31 -0800 (PST)
From: Juergen Borleis <jbe@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] Re: [PATCH] rtc: pcf85063: remove useless century handling
Date: Fri, 26 Feb 2016 12:07:31 +0100
Cc: rtc-linux@googlegroups.com,
 Alessandro Zummo <a.zummo@towertech.it>,
 linux-kernel@vger.kernel.org
References: <1456268728-343-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1456268728-343-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201602261207.31126.jbe@pengutronix.de>
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

On Wednesday 24 February 2016 00:05:28 Alexandre Belloni wrote:
> pcf85063_get_datetime() tries to handle a century bit but that bit is not
> documented and the final value is never used anywhere else in the kernel.
> [...]
> However, I found two interesting things in that driver. I'll send a
> patch shortly, removing the useless century handling.
> Also, I'm quite unsure about the year range handling. I have a patch but
> I'm not sure about the RTC behaviour when the year goes from 99 to 00.
> Can you check that works properly?

Just returned from the embedded world exhibition... Will test it.

Regards,
Juergen

=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Borleis =A0 =A0 =A0 =A0 =A0 =A0 |
Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| http://=
www.pengutronix.de/ =A0|
