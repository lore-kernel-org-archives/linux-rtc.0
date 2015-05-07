Return-Path: <rtc-linux+bncBDS7HNEFSALRBDFKVWVAKGQEPIEM26Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id p9si242223wiz.3.2015.05.07.05.05.32
        for <rtc-linux@googlegroups.com>;
        Thu, 07 May 2015 05:05:32 -0700 (PDT)
Date: Thu, 7 May 2015 14:05:31 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Iyappan Subramanian <isubramanian@apm.com>,
	Keyur Chudgar <kchudgar@apm.com>
Subject: [rtc-linux] Re: [PATCH] rtc-xgene: Set hardware dependency
Message-ID: <20150507120531.GG3465@piout.net>
References: <20150506092442.00396962@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150506092442.00396962@endymion.delvare>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 06/05/2015 at 09:24:42 +0200, Jean Delvare wrote :
> The rtc-xgene driver is only useful on X-Gene SoC.
>     
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Iyappan Subramanian <isubramanian@apm.com>
> Cc: Keyur Chudgar <kchudgar@apm.com>
> ---
>  drivers/rtc/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
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
