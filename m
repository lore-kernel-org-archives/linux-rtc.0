Return-Path: <rtc-linux+bncBDS7HNEFSALRBFUYTCVAKGQENNJP4DY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id m3si201381wia.1.2015.05.03.04.52.53
        for <rtc-linux@googlegroups.com>;
        Sun, 03 May 2015 04:52:53 -0700 (PDT)
Date: Sun, 3 May 2015 13:52:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [rtc-linux] Re: [PATCH v2] rtc: s3c: Integrate Exynos3250 into S3C6410
Message-ID: <20150503115251.GW12076@piout.net>
References: <1430544709-12852-1-git-send-email-k.kozlowski.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1430544709-12852-1-git-send-email-k.kozlowski.k@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 02/05/2015 at 14:31:49 +0900, Krzysztof Kozlowski wrote :
> From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> There are now no differences between RTC on Exynos3250 and S3C6410.
> Merge everything into one so duplicated code could be removed.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> 
> ---
> Changes since v1:
> 1. Add acks and reviews.
> ---
>  drivers/rtc/rtc-s3c.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
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
