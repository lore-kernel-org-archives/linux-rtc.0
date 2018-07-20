Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.micronovasrl.com ([212.103.203.10]:52970 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbeGTOie (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 20 Jul 2018 10:38:34 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id E85CDB00A0D
        for <linux-rtc@vger.kernel.org>; Fri, 20 Jul 2018 15:50:08 +0200 (CEST)
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QVe6h65_XvV7 for <linux-rtc@vger.kernel.org>;
        Fri, 20 Jul 2018 15:50:08 +0200 (CEST)
Subject: Re: [PATCH v10 2/4] rtc: ds1307: support m41t11 variant
To: Rob Herring <robh@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
 <20180718140946.115093-1-giulio.benetti@micronovasrl.com>
 <20180720134301.GA23613@rob-hp-laptop>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <a5dd8289-9d87-252c-e2a6-3af7237f165e@micronovasrl.com>
Date: Fri, 20 Jul 2018 15:49:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180720134301.GA23613@rob-hp-laptop>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Il 20/07/2018 15:43, Rob Herring ha scritto:
> On Wed, Jul 18, 2018 at 04:09:43PM +0200, Giulio Benetti wrote:
>> The m41t11 variant is very similar to the already supported m41t00 and
>> m41t0, but it has also 56 bytes of NVRAM.
>>
>> Add it to driver taking into account NVRAM section.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>>   .../devicetree/bindings/rtc/rtc-ds1307.txt         |  1 +
> 
> Please add acks when posting new versions.
> 
>>   drivers/rtc/rtc-ds1307.c                           | 14 ++++++++++++++
>>   2 files changed, 15 insertions(+)

Thank you for pointing me that.
v11 patchset will include them all.

Giulio
