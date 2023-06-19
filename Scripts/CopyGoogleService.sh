if [ ${TARGET_NAME} == "Messager" ]; then
  echo "Copy GoogleService-Info.plist"
  cp "${PROJECT_DIR}/GoogleService-Infos/GoogleService-Info.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"
fi
