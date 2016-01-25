Return-Path: <rtc-linux+bncBD2OLRXW4ABBBEMPTC2QKGQEZREIKBQ@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id ui7si1904585pab.0.2016.01.25.03.31.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 03:31:29 -0800 (PST)
Message-ID: <56A60503.1050004@nvidia.com>
Date: Mon, 25 Jan 2016 16:50:35 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <broonie@kernel.org>,
	<a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
	<lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <swarren@nvidia.com>, <treding@nvidia.com>,
	<vreddytalla@nvidia.com>, Chaitanya Bandi <bandik@nvidia.com>, "Mallikarjun
 Kasoju" <mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V4 2/5] mfd: max77620: add core driver for MAX77620/MAX20024
References: <1453198783-28383-1-git-send-email-ldewangan@nvidia.com> <1453198783-28383-3-git-send-email-ldewangan@nvidia.com> <569F199D.9020207@samsung.com> <56A214EB.30905@nvidia.com> <20160125112936.GB3368@x1>
In-Reply-To: <20160125112936.GB3368@x1>
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


On Monday 25 January 2016 04:59 PM, Lee Jones wrote:
> On Fri, 22 Jan 2016, Laxman Dewangan wrote:
>
>> Thanks Krzysztof for review.
>>
>> Hi Lee,
>> Are you taking the patches from your tree? Or will go in individual
>> subsystem?
> I can take the set if there are build dependencies.  If there aren't,
> then they should be routed via their respective subsystem trees.
>
>

All drivers include the header of max77620 which is part of mfd patch. 
Hence it has build dependency.
However, config of sub module will only be enabled if MFD config enabled.

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
