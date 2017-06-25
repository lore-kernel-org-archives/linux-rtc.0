Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751114AbdFYHQR (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 25 Jun 2017 03:16:17 -0400
MIME-Version: 1.0
In-Reply-To: <20170624205532.eqykr37ynpvprklf@piout.net>
References: <20170616192807.10347-1-krzk@kernel.org> <20170616192807.10347-6-krzk@kernel.org>
 <20170624205532.eqykr37ynpvprklf@piout.net>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 25 Jun 2017 09:16:14 +0200
Message-ID: <CAJKOXPfHzQTTVVJArLb3aRkedw0Yghc4JS7HnL9cFk=6S_b=-g@mail.gmail.com>
Subject: Re: [PATCH 6/6] rtc: s3c: Handle clock enable failures
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Sat, Jun 24, 2017 at 10:55 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> On 16/06/2017 at 21:28:07 +0200, Krzysztof Kozlowski wrote:
>> clk_enable() can fail so handle such case.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>  drivers/rtc/rtc-s3c.c | 72 ++++++++++++++++++++++++++++++++++++++++-----------
>>  1 file changed, 57 insertions(+), 15 deletions(-)
>>
>
> I've applied the whole series. However, quite often, on a platform,
> clk_prepare/enable are ensured to never fail and I find that the added
> complexity to handle failures is not worth it.

Indeed, the platform clocks usually cannot fail (although not always,
e.g. some PLLs might return ETIMEDOUT on sync timeout) but in this
case one of the clocks is an I2C-controlled clock from PMIC. Its
clk_prepare() can fail. It does not implement clk_enable() but this
might change in the future so to avoid unexpected issues, it is better
just to handle this properly.

Best regards,
Krzysztof
