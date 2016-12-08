Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBBOVULBAKGQEXKHWFXA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id d199si1189310wmd.1.2016.12.07.16.34.13
        for <rtc-linux@googlegroups.com>;
        Wed, 07 Dec 2016 16:34:13 -0800 (PST)
Date: Thu, 8 Dec 2016 01:34:11 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Emil Bartczak <emilbart@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 0/6] Provides bug fixes for rtc-mcp795.c
Message-ID: <20161208003411.4eqm4w4c3nuepegy@piout.net>
References: <cover.1481151278.git.emilbart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <cover.1481151278.git.emilbart@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 08/12/2016 at 00:27:36 +0100, Emil Bartczak wrote :
> This patchset provides 4 bug fixes (patch 1, 2, 3, 4), one 
> improvement (patch 5) and whitespace, indention errors fixes 
> (patch 6) in the file driver/rtc/rtc-mcp795.c.
> Please review the changes and consider to apply them to the 
> main kernel tree.
> 
> Changes from v1:
> - Introduced SoB to all patches.
> - Patch which switches to bcd2bin/bin2bcd became as first now, 
>   it also solved the shift problem presented in the previous patch 1.
> - Added restoring EXTOSC bit to its previous value.
> - All whitespace and indention fixes moved to the new patch 6.
> - Added new patch which replaces all bitmask values with the 
>   BIT(x) macro.
> 
> Emil Bartczak (6):
>   rtc: mcp795: use bcd2bin/bin2bcd.
>   rtc: mcp795: fix bitmask value for leap year (LP).
>   rtc: mcp795: fix time range difference between linux and RTC chip.
>   rtc: mcp795: fix month write resetting date to 1.
>   rtc: mcp795: Prefer using the BIT() macro.
>   rtc: mcp795: Fix whitespace and indentation.
> 
>  drivers/rtc/rtc-mcp795.c | 122 ++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 100 insertions(+), 22 deletions(-)
> 

All applied, thanks!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
