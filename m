Return-Path: <rtc-linux+bncBDS7HNEFSALRBD6X5GVAKGQEFLOS5KQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q10si451713wiz.0.2015.05.18.15.45.35
        for <rtc-linux@googlegroups.com>;
        Mon, 18 May 2015 15:45:35 -0700 (PDT)
Date: Tue, 19 May 2015 00:45:34 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Olof Johansson <olof@lixom.net>,
	Doug Anderson <dianders@chromium.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, rtc-linux@googlegroups.com,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 0/2] rtc: Fix module autoload for max77xx RTC drivers
Message-ID: <20150518224534.GZ3338@piout.net>
References: <1431530282-10672-1-git-send-email-javier.martinez@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1431530282-10672-1-git-send-email-javier.martinez@collabora.co.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 13/05/2015 at 17:18:00 +0200, Javier Martinez Canillas wrote :
> Hello Alexandre and Alessandro,
> 
> This is a trivial series that fixes module autoloading for the Maxim
> MAX77686 and MAX77802 RTC drivers that didn't export their platform
> device ID table with MODULE_DEVICE_TABLE() so modalias information
> was not available.
> 
> The series is composed of the following patches:
> 
> Javier Martinez Canillas (2):
>   rtc: max77686: Report platform modalias to fix module autoload
>   rtc: max77802: Report platform modalias to fix module autoload
> 

Both applied, thanks.

>  drivers/rtc/rtc-max77686.c | 1 +
>  drivers/rtc/rtc-max77802.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> Best regards,
> Javier
> 

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
