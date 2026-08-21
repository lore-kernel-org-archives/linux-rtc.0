Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECAD48F842
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320603; cv=none; b=g7WtxqF+4OO0YIToYhvKkttiDimtodc9PdsUVFbQ3UYq0wqwBSgxL+D7uh12xPPbgTOndIrfnpaW7jEf/tcsgiuif57u6RCHr9v0QXM3KOZza7WKkn9K1uoMHPzhXIOteGAE92haZEu3yjXmleIej+gd13PH6t42Z19f+ULqk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320603; c=relaxed/simple;
	bh=uLWrx8VP0XvMS4lZzOPKXcGwF34UPrlN0NDYQcb++Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plyNeaVi452o0wvXgWqDdQYR4yzdVPBpx1acUdOfgqKIhTEnCZFlxClbiQcFgay5Bpzldrf9+QPvZqUUvOi1Y9KT041RsnQacL1biapZF1zKCW3xV5suiIb7NRYquWgSWHXFXGxjYbe+vDK5Swle2BIlKO5JyUPQiXEXzWK7+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+LLsdd+; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+LLsdd+"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3900e39d935so922795a91.0
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320602; x=1787925402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4uKJIgLF3adY62zLAWtHXEgyUnOp/s/pf5/chMDvJU=;
        b=M+LLsdd+5WcNN2CF9wFBWTm/GoK3oATdYy88DYbuELkZKTnLYEjEbcCcfl0XbET29h
         1HjX5vmKyGKYcbyWZHFiwOqJtX5yCFQFNGZxK8IdNRoUt0JK7dS6AC2kWUaPzTeC1pGf
         e4RQ1xXhTN78uXrAvW/9WXRhlbIB8nQafUwRZ9DDsXjZa054TPQ1pLoUHLOeAZrLGZDg
         VBGLgXAE5oxyWi3jfaIYXVap6jI/e8gFe+TC8nA8Bp5a0oi5G378F1B11Tgou1qBIlw4
         AUFqOaJ9yF8iPpcZgciMcCJPiN63Q3VplkKVnZEk2hi1Cv5y0gmcEekJv1HBOFupOt4W
         V7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320602; x=1787925402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s4uKJIgLF3adY62zLAWtHXEgyUnOp/s/pf5/chMDvJU=;
        b=GV5D69f+sw/jm+NHtUUcG9pbNAd6jGDKYlzZNuRnOkJVGCcSJx9UDblohNfz+BoWQB
         qSjQ3/f6AdU4yPNweym1R4MSM9OCa3L/EFWg/bp+Z/SPLxOQxFkZnRoYNnmB+rET7940
         g1VwDKPqlZB3NcMmOnKHKNxo4IX+/hlIG+lbrJaLuqi+qG1OtcyCtRIkV0hzlyZTMFxE
         kt2UC4Hzxa8JzJydCgNcsfTsI/M876jX9armGui/5XJd/kVv5oDHFqXjmU99vObWV337
         +7e0lVZUcl+cjesDWOxiq/PPAElYWc9/JV7X7uLmMA2SqnlHmwRqpZhJVANCeqMzaZ8o
         vuMQ==
X-Gm-Message-State: AFuF++lghrW6/Kqi6SpuZWSNUfZ6TzDIxTBeMqhYJS8ix6ECOAwDmlOc
	rS7+qdcKDj2KRWVMYNPQztkCY6BqNSWlUnZEg7OzfrmVy8JXgOvhDlmA
X-Gm-Gg: AR+sD12A1AhRqlYfJFzrVz0eljde2lyi+XQtHIQ/SiOl3giO0juY/XCKA0ika18NCRc
	hvkNRjmsT5tCYbZpkkz9ZDvejsIRl4KKHPluljyCFOyCvwKqhRJ748ZC40ZUOzW9tYrVJexy0QN
	O2oOPPcNwzBSZ9eb6gERPjS/lIQSpXp/BmBUYqwdpcEanokOE4zqqzyHLC2wnNbBm0PRFs6XXZN
	DSkmyLCgfjKbRFCbZdc+LewWDqZY7xDUMXlavrUDy1HpPND9Uao8IIkmKxymVzPcf8Bd4o8qYxS
	RuzE62CSahY63PrqRwTtNiWcVrXr5Dhj0o5kw7F9Mi+9P3Ks2aMmzKHtn1TmPN0DJVCzt0C2VGF
	Mhh3L/Dwzwo9kyCmmya2cYCDGrnyk4biK33oDCmCqI0RDUP0jKQ1w05v6PSmTUbl71xMa1MTZlr
	MS5waAsLP28lmsaislHzyu6vJopL96U0Jc0zE23xxVIM5n/glpVowfzdcyKqt9O5rtfodHOVqbp
	tumvRBU08/l3yJej04YhyoM1WEJP/+lV0EQIb6ekRzniVULuATxLUH/Qwx0+g1pYZjkwOojngUb
	feQFXGODLcC2FkYWvFj0Nw==
X-Received: by 2002:a17:90b:4c0a:b0:38f:de97:b06 with SMTP id 98e67ed59e1d1-395c351386amr11634937a91.5.1787320601681;
        Fri, 21 Aug 2026 06:56:41 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:773c:1c8c:24ea:eff6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327d01ff056sm19972277eec.19.2026.08.21.06.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:56:41 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 02/17] rtc: rzn1: Handle EPROBE_DEFER for optional pps interrupt
Date: Fri, 21 Aug 2026 14:55:53 +0100
Message-ID: <20260821135608.275233-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Check for -EPROBE_DEFER from platform_get_irq_byname_optional() and handle
the deferred probe request properly.

Although the "pps" interrupt is optional, an error code of -EPROBE_DEFER
indicates that the interrupt subsystem is not yet ready. Intercept this
specific error condition, assign it to the return value, and jump to the
dis_runtime_pm label to avoid ignoring a valid probe deferral.

Fixes: eea7791e00f33 ("rtc: rzn1: implement one-second accuracy for alarms")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v4->v5:
- Added Tested-by tag from Wolfram.

v3->v4:
- Added Reviewed-by tag from Wolfram.

v2->v3:
- No changes

v1->v2:
- No changes
---
 drivers/rtc/rtc-rzn1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 305f10a8a85b..aa27ad7f5941 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -464,6 +464,10 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq_byname_optional(pdev, "pps");
+	if (irq == -EPROBE_DEFER) {
+		ret = irq;
+		goto dis_runtime_pm;
+	}
 	if (irq >= 0)
 		ret = devm_request_irq(&pdev->dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC 1s", rtc);
 
-- 
2.43.0

