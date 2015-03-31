Return-Path: <rtc-linux+bncBDKZNNNLXAHBBMGE5GUAKGQEZP4L6UQ@googlegroups.com>
Received: from mail-yh0-x22c.google.com (mail-yh0-x22c.google.com. [2607:f8b0:4002:c01::22c])
        by gmr-mx.google.com with ESMTPS id u27si539100yhu.4.2015.03.31.02.00.31
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2015 02:00:31 -0700 (PDT)
Received: by mail-yh0-x22c.google.com with SMTP id f44so1742140yhj.3
        for <rtc-linux@googlegroups.com>; Tue, 31 Mar 2015 02:00:31 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <20150331082052.GI3849@piout.net>
References: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
	<1427728773-29065-2-git-send-email-k.kozlowski@samsung.com>
	<20150331002709.GF3849@piout.net>
	<CABxcv==+h8R-tL9D5OXmYsuYfs_cLATViZ3N1veZwZBZF=fu0Q@mail.gmail.com>
	<20150331082052.GI3849@piout.net>
Date: Tue, 31 Mar 2015 11:00:31 +0200
Message-ID: <CAJKOXPemefBOfOUV_azuJbiOMGurZLTGtFKBx7rW6NCgu+sjvQ@mail.gmail.com>
Subject: Re: [rtc-linux] Re: [PATCH 1/2] drivers/rtc/rtc-s3c.c: Integrate
 Exynos3250 into S3C6410
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: rtc-linux@googlegroups.com
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Kukjin Kim <kgene@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

2015-03-31 10:20 GMT+02:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> Hi,
>
> On 31/03/2015 at 08:49:39 +0200, Javier Martinez Canillas wrote :
>> Hello Alexandre,
>>
>> On Tue, Mar 31, 2015 at 2:27 AM, Alexandre Belloni
>> <alexandre.belloni@free-electrons.com> wrote:
>> > nitpick: I would prefer rtc: rtc-s3c instead of drivers/rtc/rtc-s3c.c
>> >
>>
>> Yes but Krzysztof is following the convention used in drivers/rtc/
>> which I think is the correct thing to do even when it's different from
>> what is used all over the kernel.
>>
>
> Having a look at the git history, the first and most used prefix is
> actually 'rtc:' at some point, this started to change to 'drivers/rtc/'.
> We should probably start to get back to 'rtc:', like most subsystems.

Yes, I used "rtc: driver_name:" before but I saw that Andrew changes
them to full path when he picks the patch. So this time I wanted to
reduce the overhead for him... Anyway I'll stick to one format ("rtc:
rtc-s3c:") as you proposed.

Best regards,
Krzysztof

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
