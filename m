Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32125 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbeGKGI2 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 11 Jul 2018 02:08:28 -0400
Date: Wed, 11 Jul 2018 14:01:54 +0800
From: Ye Xiaolong <xiaolong.ye@intel.com>
To: Denis OSTERLAND <denis.osterland@diehl.com>
Cc: "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 2/5] rtc: isl1208: add support for isl1219 with tamper
 detection
Message-ID: <20180711060154.GD7170@yexl-desktop>
References: <20180710090710.9066-3-Denis.Osterland@diehl.com>
 <201807102100.7IWfwFfW%fengguang.wu@intel.com>
 <1531231616.7366.2.camel@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1531231616.7366.2.camel@diehl.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi, Denis

The patch was applied in correct sequence as you can see in the github link.

I think the question here is rtc-isl1208 can be built as a built-in module,
but it would fail if it was built as a ko.

Thanks,
Xiaolong

On 07/10, Denis OSTERLAND wrote:
>Hi,
>
>seems 2/5 was applied before 1/5.
>1/5 introduces rtc_add_group.
>
>Regards Denis
>
>Am Dienstag, den 10.07.2018, 21:20 +0800 schrieb kbuild test robot:
>> Hi Michael,
>> 
>> I love your patch! Yet something to improve:
>> 
>> [auto build test ERROR on abelloni/rtc-next]
>> [also build test ERROR on v4.18-rc4 next-20180709]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>> 
>> url:    https://github.com/0day-ci/linux/commits/Denis-OSTERLAND/rtc-isl1208-fixes-documentation-and-isl1219-support/20180710-181709
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
>> config: x86_64-randconfig-s4-07101857 (attached as .config)
>> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
>> reproduce:
>>         # save the attached .config to linux build tree
>>         make ARCH=x86_64 
>> 
>> All errors (new ones prefixed by >>):
>> 
>> > 
>> > > 
>> > > ERROR: "rtc_add_group" [drivers/rtc/rtc-isl1208.ko] undefined!
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
>Diehl Connectivity Solutions GmbH
>Geschäftsführung: Horst Leonberger
>Sitz der Gesellschaft: Nürnberg - Registergericht: Amtsgericht
>Nürnberg: HRB 32315
>___________________________________________________________________________________________________
>
>Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
>Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
>Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
>The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by
>mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited. 
