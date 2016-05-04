Return-Path: <rtc-linux+bncBDS7HNEFSALRBPMUU64QKGQEAACX5CI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e78si126340wmc.3.2016.05.04.03.09.01
        for <rtc-linux@googlegroups.com>;
        Wed, 04 May 2016 03:09:01 -0700 (PDT)
Date: Wed, 4 May 2016 12:08:50 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Michael Buesch <m@bues.ch>,
	Mylene JOSSERAND <mylene.josserand@free-electrons.com>,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: rv3029: hide unused i2c device table
Message-ID: <20160504100850.GA2430@piout.net>
References: <1462355432-473635-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1462355432-473635-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/05/2016 at 11:50:02 +0200, Arnd Bergmann wrote :
> The added support for SPI mode made it possible to configure the driver
> when I2C is disabled, leaving an unused device table:
> 
> drivers/rtc/rtc-rv3029c2.c:794:29: error: 'rv3029_id' defined but not used [-Werror=unused-variable]
> 
> This moves the table inside of the #ifdef section that has the
> only user, to avoid the harmless warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: d08f50dd0afc ("rtc: rv3029: Add support of RV3049")
> ---
>  drivers/rtc/rtc-rv3029c2.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
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
