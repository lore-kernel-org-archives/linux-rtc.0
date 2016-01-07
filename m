Return-Path: <rtc-linux+bncBCC6ZWOPXENRBU7TXC2AKGQEENHQMWQ@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id w129si266751wme.1.2016.01.07.02.11.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 07 Jan 2016 02:11:30 -0800 (PST)
From: Juergen Borleis <jbe@pengutronix.de>
To: kernel@pengutronix.de
Subject: [rtc-linux] Re: [PATCH 3/3] RTC/PCF85063: fix time/date setting
Date: Thu, 7 Jan 2016 11:13:00 +0100
Cc: rtc-linux@googlegroups.com,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-kernel@vger.kernel.org
References: <1449496174-7813-1-git-send-email-jbe@pengutronix.de> <1449496174-7813-4-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1449496174-7813-4-git-send-email-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201601071113.00076.jbe@pengutronix.de>
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

sorry, missed your comment. Please keep me on CC since I'm not subscribed t=
o=20
the list.

> > When setting a new time/date the RTC's clock must be stopped first, in
> > order to write the time/date registers in an atomic manner.
> > So, this change stops the clock first and then writes the time/date
> > registers and the clock control register (to re-enable the clock) in one
> > turn.
>
> I'd have the same comment for that patch. Using
> i2c_smbus_write_byte_data and i2c_smbus_write_block_data would make the
> code clearer and also more robust because it takes care of
> retransmissions for example.

Okay. Will have a look.

Regards,
Juergen

=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Borleis =A0 =A0 =A0 =A0 =A0 =A0 |
Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| http://=
www.pengutronix.de/ =A0|
