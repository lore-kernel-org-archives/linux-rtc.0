Return-Path: <rtc-linux+bncBAABBSX3S7HQKGQEUG6OUPI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id c23si394120ljf.4.2017.10.17.05.55.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Oct 2017 05:55:38 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: add OF and ACPI entries for
 Epson RX8130
To: Marek Vasut <marex@denx.de>, rtc-linux@googlegroups.com
Cc: Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>,
 Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 kernel@pengutronix.de
References: <20171017124607.17461-1-bst@pengutronix.de>
 <6c4c6718-fda0-80df-d217-da27108f4809@denx.de>
From: Bastian Stender <bst@pengutronix.de>
Message-ID: <c4c1e5d6-6c46-1a9a-d7b9-1f34fc1c6296@pengutronix.de>
Date: Tue, 17 Oct 2017 14:55:34 +0200
MIME-Version: 1.0
In-Reply-To: <6c4c6718-fda0-80df-d217-da27108f4809@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 10/17/2017 02:49 PM, Marek Vasut wrote:
> On 10/17/2017 02:46 PM, Bastian Stender wrote:
>> Make Epson RX8130 device tree and ACPI aware.
>>
>> Fixes: ee0981be7704 ("rtc: ds1307: Add support for Epson RX8130CE")
> 
> Fixes , really ? I don't think it's broken in any way without the ACPI
> entries.

I think it's incomplete without ACPI/OF support - all other devices do 
have entries there. But yes, it is not really a bug, so this can discarded.

Regards,
Bastian

-- 
Pengutronix e.K.
Industrial Linux Solutions
http://www.pengutronix.de/
Peiner Str. 6-8, 31137 Hildesheim, Germany
Amtsgericht Hildesheim, HRA 2686

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
