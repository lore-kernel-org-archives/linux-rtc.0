Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35294756D2
	for <linux-rtc@vger.kernel.org>; Fri,  2 Oct 2026 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936670; cv=none; b=eD/3RyErapPs7ARQ1qUi6CbVTX3bN6mvhz5FOKbYNbVwvWPwP479YuRXoM8G6zipCnKRbilZgHRgShLZYruSRDsRfjHIZ5NOH93hz7baec6kHn7z7fvG/50tOlRu6JPNIOX9X+Wk99xyamqKEd8e4NSepCuhxMHBiWbUNUv9c4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936670; c=relaxed/simple;
	bh=Us9uA+o3L80aiz1Lsm/FOAO3LtCeQ/QLKlf9cXy1zjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfty+4/DdFgK6olcPx0ApfovnwGEPfIdYyp/h1VoH/tsTlkbnW0VeHDyGzvsRzqCk+G3lMzHQfeERIjJbwDw3LxrJuHva7Vv4FJ5Df0jQr9CSQJGEtBiirHpCJuwirh0+Kun1sIKv34NsLowyKY9+FtHDmKsA49te0tZWBg5gCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL27yZjI; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL27yZjI"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so46253575e9.0
        for <linux-rtc@vger.kernel.org>; Fri, 02 Oct 2026 03:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790936667; x=1791541467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l4SU93rxO9iU4XoD2a1LOc1G1KTUpeIL9BwetV79aAo=;
        b=bL27yZjIq6ktGNW6we4rpiJ5GzwmCampPSlLfIevJzjtUm5y5q2wdN/X1M4xjVgREg
         N70eTZ3EwVkBwx7TCX5y8X8IOcdpC4Znh5m3QyIUj93yPdV385TPxXQ0NcrHaE1UYT7f
         PHxvd/w0jYEg3Npp2MQVQ62GsxLipN+lb3TSaXJNS1diZHgqMMkrZVWYKhEMLLG9iUkZ
         OgIJ+X/yEmpfQExH5BCOSDIBCanVCZJYlKGrUdVS6sO/8FVJczojZScPycpb8+hZvTvN
         j9zv8k6MsGjrX6fT1snCEZKrmNR4KdCK7s+47dIWs4tCIAFdYqYFfSxSpIl+5hhqWAOf
         aM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790936667; x=1791541467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l4SU93rxO9iU4XoD2a1LOc1G1KTUpeIL9BwetV79aAo=;
        b=y+3wHaDRgrvZzuQ5Qt26Lxz5gTEgvZuvUqlGenopqTiEIxIbvLHoDK51qCNIKB3CTG
         0nxUNkmo4z+JebLw+9jOZW1C1EzxaAjxiUwNsqBIYUqsKlgAuLOaiWOxoRmG0syVsZN8
         wvNKMQgOXL0ygwIOU0315175J51iMcQqbD9L6IKOtqYKT5VyqafUwRMCUXfR6desKj4Q
         zb/NuwxKwnTEPLqES3rCxKt+1aAOnIt7CK/Df0IEWB1rhhBUGBL4b5aYAyxt/YPi1Xuc
         83sS3tQwV0sEh47emPaTDy2VPjcfjHq15RYfQvGRnGUtH783rMxp9O72SY0P26OAcFk+
         +F7Q==
X-Forwarded-Encrypted: i=1; AKwUvByskT1dfK7uxFD/HRkT6Q9UgTEwv0I6FmtPNrxcG5q05iHN9k/6Iv6EnIwCuHk5drgtUfPumd158HU=@vger.kernel.org
X-Gm-Message-State: AFuF++l5xUAVQzyi+sd9gR6NuUGFwP5Q/v8KLcAfERnsuAAlELxsHY0H
	ULI6BUMvEwwKK60jrcS2QTtWThG27XYSZFdbB9Hn4yExbHnDbeKsOCRt
X-Gm-Gg: AYBFou0HSeybB8ahH1wRsuNMZP81ceJ47dGeEh5eo2K0jV+JXvRz1qh30m1PClu2Jtb
	BfchcKDOcv9zu1oAezwMVfrcpqI+2w4VRCWbwUGldP348FpzcmkyAw9fBn9zLg19ToxFf15lGn/
	6zCK3A4qDc5/Ps7T0+yRQ/J3E3gbdkUBDuOotEizokoouPvhj8/Z9mKQDH1AUNINcT36L2Fbyft
	710JFLk079o7pysQ88KSec7+sy13zzhBuvgg5J46ouS/UtcJuz0ID8oP0CwOCqFNGdMizwlhoKg
	kuNyX/tbsAhDPOEfDrZKeW+G4yJl17VELkCEzk/WeO2f4vH9x4h7FdlpfDvQCAQ6C/gnawnelbo
	p+IIDWzf6e2MYWZAr85q34uKcSPxaM0w1cbz2kCFs6TkGRvYF1eFZurNdhNr68mkjn32OFICVyk
	1ZozRGAlPwatDzFCOF1Ds/+OnE12rBLbWCre3JxunJ8ijVY8VWLhfeTsvUWKppAB62MS4j+1PHe
	aitspM5L8dTeKQsyZKljqMsdGzCrv/aQzqD/wuCn5J9HA==
X-Received: by 2002:a05:600c:608a:b0:49f:bcce:13f5 with SMTP id 5b1f17b1804b1-4a02758e6e1mr38928735e9.24.1790936666932;
        Fri, 02 Oct 2026 03:24:26 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027735be1sm99557875e9.11.2026.10.02.03.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:24:26 -0700 (PDT)
From: Sander Speetjens <sander.speetjens@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	sander.speetjens@gmail.com,
	pbrobinson@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v10 1/3] dt-bindings: rtc: Add missing type to trickle-voltage-millivolt
Date: Fri,  2 Oct 2026 12:24:17 +0200
Message-ID: <20261002102419.830595-2-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002102419.830595-1-sander.speetjens@gmail.com>
References: <20261002102419.830595-1-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trickle-voltage-millivolt property had no associated type.
-millivolt is not a default property unit suffix, so the schema does
not automatically infer uint32. Explicitly reference the uint32
definition so the type is correctly declared.

Suggested-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
---
V9 -> V10: No changes

 Documentation/devicetree/bindings/rtc/rtc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentation/devicetree/bindings/rtc/rtc.yaml
index efb66df82782..e46d50b1063e 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
@@ -51,6 +51,7 @@ properties:
       if trickle charger should be enabled.
 
   trickle-voltage-millivolt:
+    $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Selected voltage for trickle charger. Should be given
       if trickle charger should be enabled and the trickle voltage is different
-- 
2.55.0

