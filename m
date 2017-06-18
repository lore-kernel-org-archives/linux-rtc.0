Return-Path: <rtc-linux+bncBDIOBYPK6QDRBUOQTPFAKGQE7LDATWA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-out.m-online.net (mail-out.m-online.net. [212.18.0.10])
        by gmr-mx.google.com with ESMTPS id w193si2226155wmf.3.2017.06.18.13.53.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jun 2017 13:53:36 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: Add support for Epson RX8130CE
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <20170504103346.10842-1-marex@denx.de>
 <20170531014515.4a7yebud7qssyjok@piout.net>
Cc: rtc-linux@googlegroups.com, Arnd Bergmann <arnd@arndb.de>,
 Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>,
 Tony Lindgren <tony@atomide.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <b3fb49a6-a9f6-5887-cc2f-01e313b2fdac@denx.de>
Date: Sun, 18 Jun 2017 22:52:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170531014515.4a7yebud7qssyjok@piout.net>
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 05/31/2017 03:45 AM, Alexandre Belloni wrote:
> Hi Marek,

Hi,

> On 04/05/2017 at 12:33:46 +0200, Marek Vasut wrote:
>> Add support for yet another RTC chip, Epson RX8130CE. This time around,
>> the chip has slightly permutated registers and also the register starts
>> at 0x10 instead of 0x0 .
>>
> 
> Do you mind rebasing on top of rtc-next or linux-next because this
> driver now uses regmap for the register accesses.

Sure ... I don't have the hardware anymore, so it'll be compile-tested
only, but the conversion seems trivial enough.

-- 
Best regards,
Marek Vasut

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
