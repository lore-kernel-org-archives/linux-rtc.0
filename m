Return-Path: <rtc-linux+bncBC6YH6VTZQDRBSMK5HBAKGQE4J2HHYA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id d199si1825818wmd.1.2016.12.21.01.03.05
        for <rtc-linux@googlegroups.com>;
        Wed, 21 Dec 2016 01:03:05 -0800 (PST)
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,  rtc-linux@googlegroups.com,  Jason Cooper <jason@lakedaemon.net>,  Andrew Lunn <andrew@lunn.ch>,  Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,  Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,  linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH v2] rtc: armada38x: Followed the new
 recommendation for errata implementation
References: <20161213112510.25692-1-gregory.clement@free-electrons.com>
	<20161221004308.terkq5u5pb2hbcbw@piout.net>
Date: Wed, 21 Dec 2016 10:02:54 +0100
In-Reply-To: <20161221004308.terkq5u5pb2hbcbw@piout.net> (Alexandre Belloni's
	message of "Wed, 21 Dec 2016 01:43:08 +0100")
Message-ID: <87tw9xiri9.fsf@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,
=20
 On mer., d=C3=A9c. 21 2016, Alexandre Belloni <alexandre.belloni@free-elec=
trons.com> wrote:


I agree with all your remark expect one, see below:
[...]
>>  	rtc_update_irq(rtc->rtc_dev, 1, event);
>> =20
>>  	return IRQ_HANDLED;
>> @@ -221,6 +282,11 @@ static __init int armada38x_rtc_probe(struct platfo=
rm_device *pdev)
>>  	if (!rtc)
>>  		return -ENOMEM;
>> =20
>> +	rtc->val_to_freq =3D devm_kcalloc(&pdev->dev, SAMPLE_NR,
>> +				sizeof(struct value_to_freq), GFP_KERNEL);
>> +	if (!rtc->val_to_freq)
>> +		return -ENOMEM;
>> +
>
> The whole struct armada38x_rtc is already allocated just before. Maybe
> you can put the whole array inside the structure instead of doing a new
> allocation.

Actually it was done on purpose. Indeed the same RTC IP is used in the
Armada 3700 (a patch is coming soon), and for this IP this issue was
fixed and we do not need to store 100 read. That's why I want to
allocate the array only if needed.

Thanks,

Gregory

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
