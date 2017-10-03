Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33121 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbdJCV6D (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 3 Oct 2017 17:58:03 -0400
Date: Tue, 3 Oct 2017 16:58:01 -0500
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: rtc: mediatek: add bindings for
 MediaTek SoC based RTC
Message-ID: <20171003215801.b5cupghaamlid66y@rob-hp-laptop>
References: <cover.1506049341.git.sean.wang@mediatek.com>
 <1357cb02adb88a8a2d7c2268b8573c0a9b6f8d0c.1506049341.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357cb02adb88a8a2d7c2268b8573c0a9b6f8d0c.1506049341.git.sean.wang@mediatek.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Fri, Sep 22, 2017 at 11:33:14AM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add device-tree binding for MediaTek SoC based RTC
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../devicetree/bindings/rtc/rtc-mediatek.txt        | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mediatek.txt

Acked-by: Rob Herring <robh@kernel.org>
