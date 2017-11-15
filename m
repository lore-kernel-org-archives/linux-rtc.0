Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53170 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756727AbdKOQBf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 15 Nov 2017 11:01:35 -0500
Date: Wed, 15 Nov 2017 17:01:23 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Baolin Wang <baolin.wang@spreadtrum.com>
Cc: a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, broonie@kernel.org,
        baolin.wang@linaro.org
Subject: Re: [PATCH v3 1/2] dt-bindings: rtc: Add Spreadtrum SC27xx RTC
 documentation
Message-ID: <20171115160123.gn27j4ki5mxv4v4j@piout.net>
References: <c65b61e5e37cb43214973cb3e479ce06c4a73395.1510198341.git.baolin.wang@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c65b61e5e37cb43214973cb3e479ce06c4a73395.1510198341.git.baolin.wang@spreadtrum.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 09/11/2017 at 11:34:16 +0800, Baolin Wang wrote:
> This patch adds the binding documentation for Spreadtrum SC27xx series
> RTC device.
> 
> Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>
> ---
> Changes since v2:
>  - No updates.
> 
> Changes since v1:
>  - Use a specific chip name as compatible string.
>  - Remove useless alias.
>  - Add the parent MFD node.
> ---
>  .../devicetree/bindings/rtc/sprd,sc27xx-rtc.txt    |   27 ++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
