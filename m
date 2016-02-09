Return-Path: <rtc-linux+bncBD2OLRXW4ABBB2PR4W2QKGQEBCCPTDQ@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id ff2si2134225pad.2.2016.02.08.21.28.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2016 21:28:09 -0800 (PST)
Message-ID: <56B97632.1000208@nvidia.com>
Date: Tue, 9 Feb 2016 10:46:34 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, <lee.jones@linaro.org>,
	<alexandre.belloni@free-electrons.com>, <k.kozlowski@samsung.com>,
	<javier@osg.samsung.com>, <gregkh@linuxfoundation.org>,
	<a.zummo@towertech.it>, <cw00.choi@samsung.com>,
	<linux-kernel@vger.kernel.org>, <rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH V4 1/6] regmap: irq: add apis to unmap the
 mapped irq
References: <1454769447-785-1-git-send-email-ldewangan@nvidia.com> <1454769447-785-2-git-send-email-ldewangan@nvidia.com> <20160208145550.GE7265@sirena.org.uk> <56B8C484.7000309@nvidia.com> <20160208165912.GK7265@sirena.org.uk> <56B8C8B4.4050207@nvidia.com> <20160208181908.GM7265@sirena.org.uk>
In-Reply-To: <20160208181908.GM7265@sirena.org.uk>
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


On Monday 08 February 2016 11:49 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
>
> On Mon, Feb 08, 2016 at 10:26:20PM +0530, Laxman Dewangan wrote:
>
>> So fix need to go in the irq_domain_remove() to unamp before actually
>> destroying the irq domain?
> That's one option, but you could also do this at the regmap-irq level.
>

Do we need to dispose all virtual irq in regmap_del_irq_chip() before 
actually removing domain?
This means we need to store the created virq  in regmap_irq_chip_data 
for disposing it when removing the irq domain.

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
