Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F39154DAC6
	for <linux-rtc@vger.kernel.org>; Tue, 22 Sep 2026 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084034; cv=none; b=lVK58VtUfIDXM2CjDvNxC1NmyL7yjCFyj5IkIzDdp7Npq/m5GAoq8zdVa4oOlYZs8SNXCsQVaIAJfwdrJJuTcuoAv82LEQgrxLcEsFRGtbL6u1Bjy+XzeIX8HsAM5p4BgM0WuGTAS0m93c0PPwpD8GQcag1a0rZOKPFx5l5jOsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084034; c=relaxed/simple;
	bh=H8SjBKeODkYJuB20OhnIYOCLI18toT67xX3EcancdDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdL8iDh88SD8o30zucqLIi63r6cokK9yuZrV+YnXUX+pgzEzTuueRSQQnAnkR07bDxx2kW0XJNWrkxQKlVkpYH0xKp5VqWR2X4L9NLbxxm/bkmF0CbVmcoUv3/C6HfqcoPZ5ntgfrj7fbd7xhtMmS8HKgrHASWx9ZMGc+lLIaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SVnz+QT3; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SVnz+QT3"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e620fa473so25590675e9.1
        for <linux-rtc@vger.kernel.org>; Tue, 22 Sep 2026 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790084024; x=1790688824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ezI6opJL+TJWnK9b0Jz6azXtBu0v4XKOZOc9c416xu4=;
        b=SVnz+QT3I8ti62UzKDZqWI/t/Ky8xoFhL/3ym9+SybegBOVx489WKl0Qmri75qAh5j
         2h4w0vDlkamxb91ed6rPprLijfZS8iG+Ez0ysiNzq6ESv/pO3wsX9198r+RUn29Pk9zu
         V0prKgj3LREUVnYNIljsGZhmnFPcFKW0rxxbl4gU5noyCFbKbNTImO6yuszOBYTsZIiu
         i/CMicwx8ge90zMlR/fhX6ZhD0Bc8vvtCj+e6HBur2gehQuYIGy3/KXRXnGgHZH6GoCR
         Zjn1eq18uIU1kA7arVlw5BdCjlhLyqFDAwIi4Jar0+Q3zg876y979pZdYSnhcauvbbMQ
         8fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790084024; x=1790688824;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezI6opJL+TJWnK9b0Jz6azXtBu0v4XKOZOc9c416xu4=;
        b=ID3YfD/3VxYgESWORT4gvJjju11p5zH6EaClUuMtqwvhpUBr8Io9Apk44OOAk/fOEQ
         Uv3V2HkM9JNFiiqxWXBhW0+TD60rL9cXRtxiTRWRisFZVOyt3nx0S0+nFPzfCzD22gXo
         6kOtxV85rT2O4spzKYnQHwcISkcc9mlWTeVUU6Qz2XAa3EM+fP+8oz9QraB8NSIP0EjH
         bRXQyvCLxX6w93rXGBQHk2hxUFv+bILPDzCI9gAylod2kDY2aX4hB6i7YfjXayeVkuwM
         r5gZbGeUU0BDPyDEW8fStAwcF95sn5pqPolPiiZ7Ie/VlaYPy49HxJoivyOLDU/HUDuA
         2QXw==
X-Forwarded-Encrypted: i=1; AKwUvBzwttpxTnVgAv01BNbYqpd/THze2DB4lluByOhMPGAaaG0n600bIBwQI8CHyoTsWx0HxO/eJ/qvuIM=@vger.kernel.org
X-Gm-Message-State: AFuF++nR1hs17mQSdoeGqufVfQd8AClf1Lg3qZbpGZ51tvJcpJHVmP2p
	Qbw7s4s0E8ECAUN8oH4SROMsILkmQFXlZuDGFLrynQewaO7Sb63suSX9tAwHWh901BI=
X-Gm-Gg: AYBFou0/mrFazhuVC3HtJ77hRxEYphSNDxTBJ/jxISCzNSKwDhOloY7lGCcm4VqH10U
	B/uKhyxdZsRHLQH7t+fE4vD9uf2EGsmkhgDo2ErUavc6171ODeld4ML9SiiyimGcF15HmaaX+1Z
	MX/+8YPGjoPX8cR8crJboDIdvxz9IftwRbI2IXoHyH6UXIQocO/4NT2mctO8Ri+tqc9Q3ZPMhoG
	5fKqFJ1eq2ZVZbxNekHv5XC399oHJebUam7PcvoFliUfZgoSVH2drHlZcNXJMW9OJOWdrwDD9a9
	YQ4jfZ2Yhj9vtj58ZAssXY1WZNriujbTiKC6Hq574mFEYV55m/VjFYBo3m7GDCABnrEnCKF6xN5
	Nn3lsJYwRJBC6H8SC1x1wrlBQzYVTttJDqEbPxG1PFElgS2SCS0Gi5etFuBy0EA5QWuvY1Yt5Eu
	QYs/64+DmBZ7Ino/RhRTWqsRAobS65JKWmGm9qHDlHGlGFREcV2zg6Fb4NRVyOY+GEPJA+C+cva
	RWhlwgnNmcq+AbmzvTUucApf5L26XYYOOHq5UBPWIa4oHDh8gBfIOkbyyHR607e6FmGcTU=
X-Received: by 2002:a05:600c:81c8:b0:49c:fc6c:be08 with SMTP id 5b1f17b1804b1-49fc58581bfmr184348345e9.31.1790084023989;
        Tue, 22 Sep 2026 06:33:43 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdace76e8sm70243845e9.1.2026.09.22.06.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:33:43 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rudolf Marek <r.marek@assembler.cz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Duncan Sands <duncan.sands@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-watchdog@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] module: Remove obsolete __MODULE_STRING()
Date: Tue, 22 Sep 2026 15:32:23 +0200
Message-ID: <20260922-module-string-v1-3-c18766690185@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922-module-string-v1-0-c18766690185@suse.com>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

__MODULE_STRING() has been an alias for __stringify() since "[PATCH]
MODULE_PARM support for older modules" [1] in 2002-12. That change also
moved it to the graveyard section at the end of linux/module.h

Remove __MODULE_STRING() now that all remaining uses have been replaced
directly with __stringify().

Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..0d9157a2d487 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -886,10 +886,6 @@ extern const struct kobj_type module_ktype;
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
 
-/* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
-
-#define __MODULE_STRING(x) __stringify(x)
-
 #ifdef CONFIG_GENERIC_BUG
 void module_bug_finalize(const Elf_Ehdr *, const Elf_Shdr *,
 			 struct module *);

-- 
2.55.0
