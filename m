Return-Path: <rtc-linux+bncBDIOBYPK6QDRB2P5S7HQKGQESDS7YSA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-out.m-online.net (mail-out.m-online.net. [2001:a60:0:28:0:1:25:1])
        by gmr-mx.google.com with ESMTPS id l14si490132lje.1.2017.10.17.06.00.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Oct 2017 06:00:25 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: add OF and ACPI entries for
 Epson RX8130
To: Bastian Stender <bst@pengutronix.de>, rtc-linux@googlegroups.com
Cc: Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>,
 Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 kernel@pengutronix.de
References: <20171017124607.17461-1-bst@pengutronix.de>
 <6c4c6718-fda0-80df-d217-da27108f4809@denx.de>
 <c4c1e5d6-6c46-1a9a-d7b9-1f34fc1c6296@pengutronix.de>
From: Marek Vasut <marex@denx.de>
Message-ID: <e07c8587-7527-b927-c356-ed48751f193d@denx.de>
Date: Tue, 17 Oct 2017 15:00:23 +0200
MIME-Version: 1.0
In-Reply-To: <c4c1e5d6-6c46-1a9a-d7b9-1f34fc1c6296@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 10/17/2017 02:55 PM, Bastian Stender wrote:
> On 10/17/2017 02:49 PM, Marek Vasut wrote:
>> On 10/17/2017 02:46 PM, Bastian Stender wrote:
>>> Make Epson RX8130 device tree and ACPI aware.
>>>
>>> Fixes: ee0981be7704 ("rtc: ds1307: Add support for Epson RX8130CE")
>>
>> Fixes , really ? I don't think it's broken in any way without the ACPI
>> entries.
> 
> I think it's incomplete without ACPI/OF support - all other devices do
> have entries there. But yes, it is not really a bug, so this can discarded.

Jupp, this patch is fine, it was just the "fixes" part which looked odd.

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
