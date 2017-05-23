Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36461 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937441AbdEWO1m (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 23 May 2017 10:27:42 -0400
Date: Tue, 23 May 2017 09:27:39 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Janos Laube <janos.dev@gmail.com>,
        Paulius Zaleckas <paulius.zaleckas@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, Po-Yu Chuang <ratbert@faraday-tech.com>
Subject: Re: [PATCH 2/3] rtc: gemini: Augment DT bindings for Faraday
Message-ID: <20170523142739.34wyhtotl4jldsez@rob-hp-laptop>
References: <20170518215635.13505-1-linus.walleij@linaro.org>
 <20170518215635.13505-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170518215635.13505-2-linus.walleij@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, May 18, 2017 at 11:56:34PM +0200, Linus Walleij wrote:
> The Gemini RTC is actually a standard IP block from Faraday
> Technology called FTRTC010. Rename the bindings, add the
> generic compatible string and add definitions for the two
> available clocks.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Po-Yu Chuang <ratbert@faraday-tech.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/rtc/cortina,gemini.txt     | 14 -----------
>  .../devicetree/bindings/rtc/faraday,ftrtc010.txt   | 28 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/cortina,gemini.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt

Acked-by: Rob Herring <robh@kernel.org> 
