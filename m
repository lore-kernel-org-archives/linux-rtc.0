Return-Path: <rtc-linux+bncBDBIRTOWTALRBJPNY2VAKGQEGH4AHJY@googlegroups.com>
Received: from mail-oi0-x22c.google.com (mail-oi0-x22c.google.com. [2607:f8b0:4003:c06::22c])
        by gmr-mx.google.com with ESMTPS id x12si87964igx.1.2015.05.12.01.15.33
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 01:15:33 -0700 (PDT)
Received: by mail-oi0-x22c.google.com with SMTP id n205so124296158oig.2
        for <rtc-linux@googlegroups.com>; Tue, 12 May 2015 01:15:33 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <20150509130846.GD3338@piout.net>
References: <1430897022-63357-1-git-send-email-eddie.huang@mediatek.com> <20150509130846.GD3338@piout.net>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Tue, 12 May 2015 16:15:13 +0800
Message-ID: <CAGS+omArcu3caKZo56Db2u+84WAVJiMzkr+1uS6tr_zfwARQ7A@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v4 0/3] Add Mediatek SoC RTC driver
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Eddie Huang <eddie.huang@mediatek.com>, Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>, srv_heupstream@mediatek.com,
	Samuel Ortiz <sameo@linux.intel.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org,
	Sascha Hauer <kernel@pengutronix.de>, Tomasz Figa <tfiga@google.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

On Sat, May 9, 2015 at 9:08 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 06/05/2015 at 15:23:39 +0800, Eddie Huang wrote :
>> RTC is one submodule of Mediatek MT6397 PMIC chip[1]. This series
>> support RTC driver that work with Mediatek SoC like MT8135, MT8173.
>> It implements second counter and also provide alarm function.
>>
>> This series base on 4.1-rc1, Test ok on MT8173 platform.
>>
>> [1] https://lkml.org/lkml/2015/1/23/325
>>
>
> All applied, thanks!

To which git tree & branch did you apply these patches?

Thanks,
-Daniel

>
>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

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
