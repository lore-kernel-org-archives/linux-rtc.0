Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:56763 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753355AbdKHFsz (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 8 Nov 2017 00:48:55 -0500
Received: by mail-ot0-f195.google.com with SMTP id i19so1369138ote.13
        for <linux-rtc@vger.kernel.org>; Tue, 07 Nov 2017 21:48:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171108053522.qhoagssswonevae4@piout.net>
References: <7037c5053a533505f38fc036290a398989cfdafc.1510051749.git.baolin.wang@spreadtrum.com>
 <b053858c3325e7c35436f35adf09b5df90106d42.1510051749.git.baolin.wang@spreadtrum.com>
 <20171108034409.cm65hvuhz67hmz3b@piout.net> <CAMz4kuK=7W7t63Axi=jcqLPYz-L=MF=uE-8rNNf9LhqP1E=hXw@mail.gmail.com>
 <20171108053522.qhoagssswonevae4@piout.net>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 8 Nov 2017 13:48:54 +0800
Message-ID: <CAMz4kuJNALMSmGV7tSiGZMj6S2=5LyfaqTpzowzM95gLKpHO1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] rtc: sprd: Add Spreadtrum RTC driver
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Baolin Wang <baolin.wang@spreadtrum.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rtc@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 8 November 2017 at 13:35, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 08/11/2017 at 13:29:21 +0800, Baolin Wang wrote:
>> > Don't do that. This is a valuable information. If you know the time is
>> > invalid, return -EINVAL in read_time(). What your are doing here is
>> > confusing the system by making it believe your fake date is the correct
>> > time.
>>
>> Usually for mobile device, we should give one reasonable start time if
>> the RTC powered down. Anyway I can remove this feature now.
>> Very appreciated for your helpful comments.
>
> Then userspace will have -EINVAL when reading the RTC and will be able
> to set the RTC to whatever value it wants. Don't encode that policy in
> the kernel.

That's great. Thanks for explanation.

-- 
Baolin.wang
Best Regards
