Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:56946 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbdKHFdq (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 8 Nov 2017 00:33:46 -0500
Received: by mail-ot0-f194.google.com with SMTP id i19so1348302ote.13
        for <linux-rtc@vger.kernel.org>; Tue, 07 Nov 2017 21:33:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171108051224.cfvbglubjpih2dm3@piout.net>
References: <7037c5053a533505f38fc036290a398989cfdafc.1510051749.git.baolin.wang@spreadtrum.com>
 <20171108031520.zx2ipqugiyypmpms@piout.net> <CAMz4kuKPtTv0brSgcZb9UKM5n4T_dc+=0k6HoT7BAo1RWqfqpg@mail.gmail.com>
 <20171108051224.cfvbglubjpih2dm3@piout.net>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 8 Nov 2017 13:33:45 +0800
Message-ID: <CAMz4kuK2yOJEGEaJRutyU-8qEM_mO+JvOPnDhtjouHTk80Qphw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: rtc: Add Spreadtrum SC27xx RTC documentation
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

On 8 November 2017 at 13:12, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 08/11/2017 at 13:02:59 +0800, Baolin Wang wrote:
>> Hi Alexandre,
>>
>> On 8 November 2017 at 11:15, Alexandre Belloni
>> <alexandre.belloni@free-electrons.com> wrote:
>> > Hi,
>> >
>> > On 07/11/2017 at 19:34:07 +0800, Baolin Wang wrote:
>> >> This patch adds the binding documentation for Spreadtrum SC27xx series
>> >> RTC device.
>> >>
>> >> Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>
>> >> ---
>> >>  .../devicetree/bindings/rtc/sprd,sc27xx-rtc.txt    |   16 ++++++++++++++++
>> >>  1 file changed, 16 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt b/Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt
>> >> new file mode 100644
>> >> index 0000000..971d3a2
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt
>> >> @@ -0,0 +1,16 @@
>> >> +Spreadtrum SC27xx Real Time Clock
>> >> +
>> >> +Required properties:
>> >> +- compatible: should be "sprd,sc27xx-rtc".
>> >
>> > Don't use wildcards in a compatible, use a specific chip model. later
>> > chips may or may not be compatible with that one.
>>
>> Our Spreadtrum SC27xx series PMICs contain SC2720, SC2721, SC2723,
>> SC2730 and SC2731. They all integrate the same RTC IP, so I think it
>> will be better to use "sc27xx" string. Our PMIC driver also used the
>> "sprd,sc27xx-rtc" sting which has been merged into Lee's MFD next
>> tree.
>>
>
> And at some point it time, you'll have sc2750 or 2770 with a different
> rtc and everything will get confusing.

Yes, I can understand your concern. OK, I will change to a specific
chip name in next version. Thanks.

>
> I should have been copied on the mfd series if you wanted to avoid that.
> Anyway, I'm pretty sure Rob will have the same opinion.
>
-- 
Baolin.wang
Best Regards
