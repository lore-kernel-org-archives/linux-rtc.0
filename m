Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A665480DEC
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792336262; cv=none; b=cUTKT06cGdd9K45y3HooV2fVIGmA9LBrW+eTE/sA7ExiF7TYrugK0WY5xdSnGvdPy5WmgE2UbojOXFKvuAPRs/9A4SDkUmyQ5G3dYWN17aakoeNKzcnEx3gVHKfKykg5HrLGtjHsaEoRH/tqrGpJ90G+o+cT8AOtJejhn3oEuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792336262; c=relaxed/simple;
	bh=npIq4JBhHMqo+TX87kz0X8PXV65z96/F91/bn6YAQ8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bH4Yoea+nEzKWyMLln3Z79TPPpTiVqqofWb6xjWYtKF6HeD7w+HyN6ldHHeHk249oF1bB0nDcNq9+4YQjqb0mC7IQsuw0oqfbZsETxq+ONj+pVpaziZcT0YMvn3XRVaJDa/SaghTeUaMUAIOYHDiAKSE95n3dGtEA8d67+gpHF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L11ABpFu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L11ABpFu"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso14732595e9.2
        for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 08:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792336259; x=1792941059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IL0E/vt9sxXlhTRMpInaKfEm9NwJYqDZiQ8jv73u6U8=;
        b=L11ABpFu216a9tZTwynSiGWwFcNRKWJZAkA3m/yta/wY0Iv4/PwXdjxV8lHsEDjJjA
         PWDIdgQSt4cF5F59l5zieXd6Ifsy5ul+Ow4zk2Mi9fahNhTzfoMOw2M6xR/LNqfRduJ1
         HwKPuXT5Mb/Q80Huc/XvsL0yCGPhItBF6Uck1xoFW/XQjNX0XPEaQR4IYtBtNzmj2DrV
         WoplGBU46BCUYO3N8utiCMfZhkUvWvxFqT5Pmay2QDI0aADvIMgi/MDl3doWWK9hfVNP
         obkWazV8YUfk7dPrpJd6Vz7oMIbaJQfRK34+3Pb1itny8knfUT2bNGqFFOr1RbZBgitA
         obZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792336259; x=1792941059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IL0E/vt9sxXlhTRMpInaKfEm9NwJYqDZiQ8jv73u6U8=;
        b=FS2DKepO60LJ8eP/zt2CRvV3d7CK2hR25I5jODTu6/p+90E4l3kwwrxpZEe25n0TPe
         shmE506RQ6dJSM3zOZlQFlmMrnOSpUaukkw3Bi4+lNYTKxX9/b9ZFjM8JpbNPi3nyanz
         Y4M0HHFAy4VOG98H7WBOFGqEen+TqMyte3WHeVu6YFSzWnrfV6urWU/rtGUEmF8V/Dvg
         Kfv9DrrCv+1s3A0InnYQq6qPyoZGJ75xgkTHoUEbBrvDwLa7l+IDYnE3zJnnxia5cfGX
         MZ+x5PR6pvYiwDDhYOa2jNPTYkpiU4/QdczIjjx3iXOi/AF9Y1u7nvHklLfUfi5mO8Fz
         Zmlw==
X-Forwarded-Encrypted: i=1; AKwUvBzBtgX6mF8RBZcviBkaxb664HKM+ghe9b0W4YLhbCaYCk+0IbGq+0OdRdkG8SyohMdxhDMrjXdMQlY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEA6e/OYcVdnuBbE1e7SXH+eOkqZbGDjEFBJBB/kuqpCbKPy26
	Me6oH/IrZVdH+bDk1wsVHBLovw1UfFjM3x+5FOEYxsiHzrgKcirX311D
X-Gm-Gg: AYBFou1hhvCVGYq2tdAOjiAUZxt6VHqp5kHsBjHcB5PIS0s5EOmfOPgGZ9Ki+u+9aQX
	LyWUGVR2FlpjTZRxDxsCn4G/xLd5QVk88IzYNJUxeWBMz5EsXRhqm0IPS5J6vAgJ/1q98EtcR6w
	qmjsvtypgDq3cbgsdPeGm+/7zT+WOBOhejbeQLLJbU5AhX0opPgUPk3vDj/nYbo0TyYuDjCQ4Cz
	gcddAu9IK/E0WJKDeeE/DlNkkqXGbCsSMm6hQamYDbJa85YMfe56QJIkgUkhIzyFHLsD9M2P+QT
	4soRS1HqUs+2GM8wXBgsJCngOKvkVmMReX0mujGXlLijTAiaZGK7sFUzl8Kin+9yTjsY/u9WWb/
	iWUbJyWqENxXk8e+FmURniwDVniYZlCjY1YwGqLcKB8YJJFFNYWK85XaWIpw+U5XTSjvBdMBceG
	t4ctZnBh6Km+9TMMdve9iAYsbH69hlxptaUPqSQtxYH/4mzZZ1wOL288C/r5ZYIHyQ7/scWQ4mQ
	Muv+/8Ko9G9C24L2zA4DDJIq2DVg9q9Pyf2CTb3N7P3Mg==
X-Received: by 2002:a05:6000:24c3:b0:488:57ad:d5c8 with SMTP id ffacd0b85a97d-48e079759cbmr9621680f8f.3.1792336259484;
        Sun, 18 Oct 2026 08:10:59 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd503a0dsm17743957f8f.47.2026.10.18.08.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:10:58 -0700 (PDT)
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
Subject: [PATCH v14 1/3] dt-bindings: rtc: Add missing type to trickle-voltage-millivolt
Date: Sun, 18 Oct 2026 17:10:54 +0200
Message-ID: <20261018151056.1051330-2-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018151056.1051330-1-sander.speetjens@gmail.com>
References: <20261018151056.1051330-1-sander.speetjens@gmail.com>
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
V13 -> V14: No changes

V13: https://lore.kernel.org/linux-rtc/20261018150028.1047172-1-sander.speetjens@gmail.com

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
2.56.0

