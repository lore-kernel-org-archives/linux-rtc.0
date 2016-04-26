Return-Path: <rtc-linux+bncBAABBNH57W4AKGQEM5WXFYI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0120.outbound.protection.outlook.com. [104.47.0.120])
        by gmr-mx.google.com with ESMTPS id cs5si1238640igb.0.2016.04.26.07.44.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 07:44:04 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH 1/3] mfd: add Cypress FM33256B Processor
 Companion driver
To: Rob Herring <robh@kernel.org>
References: <1461150471-23163-1-git-send-email-jlp@gomspace.com>
 <1461150471-23163-2-git-send-email-jlp@gomspace.com>
 <20160422193232.GA9737@rob-hp-laptop>
CC: <lee.jones@linaro.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<alexandre.belloni@free-electrons.com>, <a.zummo@towertech.it>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
From: Jeppe Ledet-Pedersen <jlp@gomspace.com>
Message-ID: <571F7E60.9040106@gomspace.com>
Date: Tue, 26 Apr 2016 16:42:40 +0200
MIME-Version: 1.0
In-Reply-To: <20160422193232.GA9737@rob-hp-laptop>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22/04/16 21:32, Rob Herring wrote:
> On Wed, Apr 20, 2016 at 01:07:49PM +0200, Jeppe Ledet-Pedersen wrote:
[snip]
>> +
>> +The MFD exposes two subdevices:
>> +- The FRAM: "cypress,fm33256b-fram"
>> +- The RTC: "cypress,fm33256b-rtc"
>> +
>> +Example:
>> +
>> +spi1: spi@f800800 {
>> +	status = "okay";
>> +	cs-gpios = <&pioC 25 0>;
>> +
>> +	fm33256b@0 {
>> +		compatible = "cypress,fm33256b";
>> +		spi-max-frequency = <10000000>;
>> +		cypress,charge-enabled;
>> +		cypress,charge-fast;
>> +		reg = <0>;
>> +	};
> 
> Where's the 2nd sub device?

Hi Rob,

Right now I just add the two sub-devices using mfd_add_devices in the
fm33256b_probe function in my MFD driver. Would it be better to check
for compatible child nodes before adding each sub-device, like it's done
in drivers/mfd/tc3589x.c?

Thanks,

-Jeppe


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
