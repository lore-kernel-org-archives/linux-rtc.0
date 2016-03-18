Return-Path: <rtc-linux+bncBDS7HNEFSALRBIETWK3QKGQERFJPCBQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f75si29867wme.3.2016.03.18.16.05.01
        for <rtc-linux@googlegroups.com>;
        Fri, 18 Mar 2016 16:05:01 -0700 (PDT)
Date: Sat, 19 Mar 2016 00:05:01 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Oleksij Rempel <linux@rempel-privat.de>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: asm9260: remove incorrect __init/__exit annotations
Message-ID: <20160318230501.GD2828@piout.net>
References: <1458078287-586232-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1458078287-586232-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 15/03/2016 at 22:44:31 +0100, Arnd Bergmann wrote :
> The probe and remove callbacks of the platform driver are marked __init
> and __exit, respectively. However, this is not a correct way to annotate
> them, as it will result in those sections to be discarded at link time
> or after boot, while we can actually call them again based on manual
> unbinding, or deferred probing.
> 
> Kbuild warns about the problem:
> 
> WARNING: drivers/rtc/rtc-asm9260.o(.data+0x0): Section mismatch in reference from the variable asm9260_rtc_driver to the function .init.text:asm9260_rtc_probe()
> 
> This removes the annotations, so we no longer branch into missing
> code and avoid the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 125e550fd257 ("rtc: add Alphascale asm9260 driver")
> ---
>  drivers/rtc/rtc-asm9260.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
