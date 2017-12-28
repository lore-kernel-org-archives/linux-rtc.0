Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from forward4j.cmail.yandex.net ([5.255.227.22]:56847 "EHLO
        forward4j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751411AbdL1Oaq (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 28 Dec 2017 09:30:46 -0500
From: Ozgur <ozgur@goosey.org>
To: Aishwarya Pant <aishpant@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>,
        Jonathan Corbet <corbet@lwn.net>
In-Reply-To: <434381514470951@web50o.yandex.ru>
References: <20171228133132.GA3927@mordor.localdomain> <434381514470951@web50o.yandex.ru>
Subject: Re: rtc: sysfs: move sysfs interface to Documentation/ABI
MIME-Version: 1.0
Message-Id: <480511514471013@web35j.yandex.ru>
Date: Thu, 28 Dec 2017 17:23:33 +0300
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>



28.12.2017, 17:22, "Ozgur" <okaratas@yandex.com>:
> 28.12.2017, 16:31, "Aishwarya Pant" <aishpant@gmail.com>:
>>  Hi

 Hello,

>>  In Documentation/rtc.txt, there is a description of the sysfs
>>  interface which could be moved to Documentation/ABI.
>>
>>  Would such a change be useful?
>>
>>  The ABI documentation format looks like the following:
>>
>>  What: (the full sysfs path of the attribute)
>>  Date: (date of creation)
>>  KernelVersion: (kernel version it first showed up in)
>>  Contact: (primary contact)
>>  Description: (long description on usage)
>>
>>  I am doing this in an exercise to move sysfs ABI interfaces (which are
>>  documented) to their right place i.e. in Documentation/ABI along with the rest.

 Do I understand right? Are you want to make the rtc.txt part the same format as ABI folder?
 for example create to RTC folder and add /dev/rtc what, date, kernelversion, contact right?

 This can be a good idea and I can help.

>>  Aishwarya

Ozgur
