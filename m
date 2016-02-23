Return-Path: <rtc-linux+bncBDS7HNEFSALRBIGQWO3AKGQEVFVWV4Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c143si24946wmd.1.2016.02.23.15.15.44
        for <rtc-linux@googlegroups.com>;
        Tue, 23 Feb 2016 15:15:44 -0800 (PST)
Date: Wed, 24 Feb 2016 00:15:43 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Denys Vlasenko <vda.linux@googlemail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: s5m: De-inline large functions to save space
Message-ID: <20160223231543.GE10681@piout.net>
References: <1455588282-7251-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1455588282-7251-1-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 16/02/2016 at 11:04:42 +0900, Krzysztof Kozlowski wrote :
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
> ---
>  drivers/rtc/rtc-s5m.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
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
