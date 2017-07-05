Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36660 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751703AbdGEVxB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 5 Jul 2017 17:53:01 -0400
Subject: Re: [PATCH] rtc: brcmstb-waketimer: fix settime function
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Markus Mayer <mmayer@broadcom.com>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20170628200839.3114345-1-arnd@arndb.de>
 <20170705211327.guccztud22hcmfjy@piout.net>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <aa080524-e532-6f72-f81b-35a0d3e919fb@gmail.com>
Date: Wed, 5 Jul 2017 14:52:46 -0700
MIME-Version: 1.0
In-Reply-To: <20170705211327.guccztud22hcmfjy@piout.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 07/05/2017 02:13 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 28/06/2017 at 22:07:34 +0200, Arnd Bergmann wrote:
>> gcc warns about an unused variable in the new driver:
>>
>> drivers/rtc/rtc-brcmstb-waketimer.c: In function 'brcmstb_waketmr_settime':
>> drivers/rtc/rtc-brcmstb-waketimer.c:142:6: error: unused variable 'ret' [-Werror=unused-variable]
>>
>> The same function also doesn't handle overflow correctly, this makes
>> it return -EINVAL when passed a time that doesn't fit within the
>> range of the register.
>>
>> Fixes: 9f4ad359c801 ("rtc: brcmstb-waketimer: Add Broadcom STB wake-timer")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/rtc/rtc-brcmstb-waketimer.c | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>
> 
> I've squashed it in the original commit, I hope this is fine for you.

Works for me, thanks Alexandre!
-- 
Florian
