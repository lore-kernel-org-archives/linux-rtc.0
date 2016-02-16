Return-Path: <rtc-linux+bncBAABBXXGRS3AKGQEH4LAHNI@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id yd9si720451pab.1.2016.02.16.06.34.06
        for <rtc-linux@googlegroups.com>;
        Tue, 16 Feb 2016 06:34:06 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH] rtc: s5m: De-inline large functions to save space
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Sangbeom Kim <sbkim73@samsung.com>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 rtc-linux@googlegroups.com
References: <1455588282-7251-1-git-send-email-k.kozlowski@samsung.com>
Cc: Denys Vlasenko <vda.linux@googlemail.com>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56C33358.7040807@osg.samsung.com>
Date: Tue, 16 Feb 2016 11:34:00 -0300
MIME-Version: 1.0
In-Reply-To: <1455588282-7251-1-git-send-email-k.kozlowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello Krzysztof,

On 02/15/2016 11:04 PM, Krzysztof Kozlowski wrote:
> Few functions were marked inline even though they were relatively large
> and sometimes used in multiple places. De-inline them to let the
> compiler decide whether optimization makes sense. This fixes inline_hunt
> report:
> drivers/rtc/rtc-s5m.c: Deinline s5m8767_rtc_set_alarm_reg, save 704 bytes
> drivers/rtc/rtc-s5m.c: Deinline s5m8767_wait_for_udr_update, save 192 bytes
>
> Reported-by: Denys Vlasenko <vda.linux@googlemail.com>
> Cc: Denys Vlasenko <vda.linux@googlemail.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

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
