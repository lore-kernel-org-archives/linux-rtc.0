Return-Path: <Nicolas.FERRE@atmel.com>
Message-ID: <5369E8C6.1070409@atmel.com>
Date: Wed, 7 May 2014 10:03:18 +0200
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Bryan Evenson
	<bevenson@melinkcorp.com>, Boris BREZILLON
	<boris.brezillon@free-electrons.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard
	<plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] rtc: rtc-at91rm9200: fix infinite wait for ACKUPD irq
References: <94c06375c1b44c8eb5233b0ccf2e4b13@BY2PR05MB048.namprd05.prod.outlook.com> <1399386481-18643-1-git-send-email-boris.brezillon@free-electrons.com> <aed75d16aa46476eb6f6c5b0d4bef30d@BLUPR05MB037.namprd05.prod.outlook.com> <20140506211040.GF11243@piout.net>
In-Reply-To: <20140506211040.GF11243@piout.net>
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <rtc-linux.googlegroups.com>

On 06/05/2014 23:10, Alexandre Belloni :
> Hi,
> 
> On 06/05/2014 at 19:06:56 +0000, Bryan Evenson wrote :
>>
>> I'd assume this patch would be backported to the longterm releases?
>>
> 
> If by longterm, you mean the linux4sam tree, 3.10 branch, it is up to
> Nicolas to take it. I believe it will be pretty easy to convince him ;)

Absolutely, it is always easy to convince me with:
- good commit message
- script to reproduce the issue
- follow-up of the patch plus testing
- dialogue between skilled kernel developers

So, yes, I will "ack" the patch and immediately integrate it in our
linux4sam 3.10 branch.

On the other hand, I let Boris add the "stable" tag to his original patch.

Thanks to all of you for this fix. Bye,
-- 
Nicolas Ferre
