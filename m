Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43883 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758363AbdKPCQu (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 15 Nov 2017 21:16:50 -0500
Received: by mail-oi0-f66.google.com with SMTP id f135so2311746oib.0
        for <linux-rtc@vger.kernel.org>; Wed, 15 Nov 2017 18:16:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171115160123.gn27j4ki5mxv4v4j@piout.net>
References: <c65b61e5e37cb43214973cb3e479ce06c4a73395.1510198341.git.baolin.wang@spreadtrum.com>
 <20171115160123.gn27j4ki5mxv4v4j@piout.net>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 16 Nov 2017 10:16:49 +0800
Message-ID: <CAMz4ku+8dOkv4BD8-UdBJQvxfJing6gLftLykMg2z95pPmsKJw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: rtc: Add Spreadtrum SC27xx RTC documentation
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

On 16 November 2017 at 00:01, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 09/11/2017 at 11:34:16 +0800, Baolin Wang wrote:
>> This patch adds the binding documentation for Spreadtrum SC27xx series
>> RTC device.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>
>> ---
>> Changes since v2:
>>  - No updates.
>>
>> Changes since v1:
>>  - Use a specific chip name as compatible string.
>>  - Remove useless alias.
>>  - Add the parent MFD node.
>> ---
>>  .../devicetree/bindings/rtc/sprd,sc27xx-rtc.txt    |   27 ++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt
>>
> Applied, thanks.

Thanks Alexandre and Rob.

-- 
Baolin Wang
Best Regards
