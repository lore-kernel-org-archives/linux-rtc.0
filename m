Return-Path: <rtc-linux+bncBDS7HNEFSALRBHNGQS3QKGQEORRSWKI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s141si49994wmd.1.2016.03.09.22.24.29
        for <rtc-linux@googlegroups.com>;
        Wed, 09 Mar 2016 22:24:29 -0800 (PST)
Date: Thu, 10 Mar 2016 07:24:06 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Subject: [rtc-linux] Re: [PATCH v4 2/7] rtc: merge ds3232 and ds3234
Message-ID: <20160310062406.GF9868@piout.net>
References: <1457278073-11627-1-git-send-email-akinobu.mita@gmail.com>
 <1457278073-11627-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1457278073-11627-2-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 07/03/2016 at 00:27:48 +0900, Akinobu Mita wrote :
> According to "Feature Comparison of the DS323x Real-Time Clocks"
> (http://pdfserv.maximintegrated.com/en/an/AN5143.pdf), DS3232 and
> DS3234 are very similar.
> 
> This merges rtc-ds3232 and rtc-ds3234 with using regmap.
> This change also enables to support alarm for ds3234.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Suggested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Dennis Aberilla <denzzzhome@yahoo.com>
> ---
> * v4
> - stop splitting core and i2c modules
> 
>  drivers/rtc/Kconfig      |  42 ++++++------
>  drivers/rtc/Makefile     |   1 -
>  drivers/rtc/rtc-ds3232.c | 167 ++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/rtc/rtc-ds3234.c | 171 -----------------------------------------------
>  4 files changed, 187 insertions(+), 194 deletions(-)
>  delete mode 100644 drivers/rtc/rtc-ds3234.c
> 

I applied it after adding the REGMAP_I2C and REGMAP_SPI selection. I
also fixed the ds323?_unregister_driver prototype (void instead of int)
when I2C or SPI are not selected.

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
