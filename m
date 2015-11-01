Return-Path: <rtc-linux+bncBDS7HNEFSALRBQU23GYQKGQEYPR3I5Q@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t2si379240wme.1.2015.11.01.09.34.57
        for <rtc-linux@googlegroups.com>;
        Sun, 01 Nov 2015 09:34:57 -0800 (PST)
Date: Sun, 1 Nov 2015 18:34:57 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, Donggeun Kim <dg77.kim@samsung.com>,
	MyungJoo Ham <myungjoo.kim@samsung.com>,
	KyungMin Park <kyungmin.park@samsung.com>
Subject: [rtc-linux] Re: [PATCH v3] rtc: rtc-s3c: Set year, month, day value
 for setting alarm
Message-ID: <20151101173457.GC22331@piout.net>
References: <1446378544-18020-1-git-send-email-k.kozlowski.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1446378544-18020-1-git-send-email-k.kozlowski.k@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 01/11/2015 at 20:49:04 +0900, Krzysztof Kozlowski wrote :
> This patch sets year, month, day value for set_alarm function.
> The current driver omits to set the values.
> 
> This fixes setting wake alarm for dates different than current day.
> Without the patch the alarm scheduled for tomorrow would fire today on
> chosen time.
> 
> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.kim@samsung.com>
> Signed-off-by: KyungMin Park <kyungmin.park@samsung.com>
> [k.kozlowski: Rebase and test the patch, update commit message]
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> 
Applied, many thanks for your reviews.

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
