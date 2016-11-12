Return-Path: <rtc-linux+bncBDL53MW2W4EBBAH6TPAQKGQEVOPBQ7I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com. [2607:f8b0:4001:c0b::244])
        by gmr-mx.google.com with ESMTPS id v192si2463589itb.3.2016.11.12.03.37.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Nov 2016 03:37:36 -0800 (PST)
Received: by mail-it0-x244.google.com with SMTP id b123so2476611itb.2
        for <rtc-linux@googlegroups.com>; Sat, 12 Nov 2016 03:37:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161112112009.34gwcedl57v77ng5@earth>
References: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
 <1478945246-32056-4-git-send-email-Nicolae_Rosia@mentor.com> <20161112112009.34gwcedl57v77ng5@earth>
From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Date: Sat, 12 Nov 2016 13:37:35 +0200
Message-ID: <CAKP5S=27ZHZyKj9LWVDaeSXzCyrsrJmNbc3r-YRXXXKsk74yag@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: rtc-twl: use irq_of_parse_and_map helper
To: Sebastian Reichel <sre@kernel.org>
Cc: Nicolae Rosia <Nicolae_Rosia@mentor.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com,
	linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,


On Sat, Nov 12, 2016 at 1:20 PM, Sebastian Reichel <sre@kernel.org> wrote:
> This patch is missing long description. I would have patched it the
> other way around. There is no reason to use irq_of_parse_and_map if
> generic platform_get_irq can be used.
Since this patch series removes platform support and makes the driver DT only,
I thought it would be a good idea to make it explicit that it depends on OF_IRQ.

Regards,
Nicolae

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
