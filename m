Return-Path: <rtc-linux+bncBDT6DFON3EBBBBMH5GUAKGQEHXDCQ6Y@googlegroups.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com. [209.85.212.174])
        by gmr-mx.google.com with ESMTPS id el6si770530wib.0.2015.03.30.23.49.39
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2015 23:49:39 -0700 (PDT)
Received: by mail-wi0-f174.google.com with SMTP id gn9so13370400wib.1
        for <rtc-linux@googlegroups.com>; Mon, 30 Mar 2015 23:49:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150331002709.GF3849@piout.net>
References: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
	<1427728773-29065-2-git-send-email-k.kozlowski@samsung.com>
	<20150331002709.GF3849@piout.net>
Date: Tue, 31 Mar 2015 08:49:39 +0200
Message-ID: <CABxcv==+h8R-tL9D5OXmYsuYfs_cLATViZ3N1veZwZBZF=fu0Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/2] drivers/rtc/rtc-s3c.c: Integrate
 Exynos3250 into S3C6410
From: Javier Martinez Canillas <javier@dowhile0.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Chanwoo Choi <cw00.choi@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, rtc-linux@googlegroups.com,
	Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hello Alexandre,

On Tue, Mar 31, 2015 at 2:27 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> nitpick: I would prefer rtc: rtc-s3c instead of drivers/rtc/rtc-s3c.c
>

Yes but Krzysztof is following the convention used in drivers/rtc/
which I think is the correct thing to do even when it's different from
what is used all over the kernel.

> On 30/03/2015 at 17:19:32 +0200, Krzysztof Kozlowski wrote :
>> There are now no differences between RTC on Exynos3250 and S3C6410.
>> Merge everything into one so duplicated code could be removed.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier

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
