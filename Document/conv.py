import pandas as pd
import json
import os

def excel_to_json(excel_file, json_file):
    """
    엑셀 파일에서 필요한 필드를 추출하여 JSON 파일로 변환합니다.
    
    Parameters:
    - excel_file: 입력 엑셀 파일 경로
    - json_file: 출력 JSON 파일 경로
    """
    # 엑셀 파일 읽기
    try:
        df = pd.read_excel(excel_file)
        print(f"엑셀 파일 읽기 성공: {excel_file}")
        print(f"전체 행 수: {len(df)}")
        
        # 컬럼명 확인
        print("데이터프레임 컬럼명:", df.columns.tolist())
        
        # 필요한 컬럼만 선택 (엑셀 파일의 실제 컬럼명)
        required_columns = ['발급사', 'BIN', '전표인자명', '개인/법인', '브랜드', '신용/체크']
        
        # 존재하는 컬럼만 선택하도록 확인
        available_columns = [col for col in required_columns if col in df.columns]
        
        if len(available_columns) < len(required_columns):
            missing = set(required_columns) - set(available_columns)
            print(f"주의: 다음 필수 컬럼이 없습니다 - {missing}")
            
            # 매핑 실패 시 내용 확인을 위해 몇 행 출력
            print("\n처음 5개 행 샘플:")
            print(df.head(5).to_string())
            
            # 컬럼명을 직접 입력받도록 안내
            print("\n실제 컬럼명과 필요한 컬럼 간의 매핑을 직접 설정해야 합니다.")
            
            # 존재하는 컬럼만으로 계속 진행
            print(f"존재하는 컬럼 {available_columns}으로만 계속 진행합니다.")
        
        # 선택된 컬럼으로 새 데이터프레임 생성
        if available_columns:
            df_selected = df[available_columns]
            
            # NaN 값을 None으로 변환 (JSON null로 변환됨)
            df_selected = df_selected.where(pd.notna(df_selected), None)
            
            # JSON 키 이름으로 컬럼 매핑 (이 부분이 중요)
            column_mapping = {
                '발급사': 'issuer',
                'BIN': 'bin',
                '전표인자명': 'arg_name',
                '개인/법인': 'card_gubun',
                '브랜드': 'brand',
                '신용/체크': 'card_type'
            }
            
            # 매핑된 컬럼이름으로 변경
            df_selected = df_selected.rename(columns=column_mapping)
            
            # 데이터프레임을 JSON 변환 가능한 리스트로 변환
            records = df_selected.to_dict(orient='records')
            
            # JSON 파일로 저장
            with open(json_file, 'w', encoding='utf-8') as f:
                json.dump(records, f, ensure_ascii=False, indent=2)
            
            print(f"JSON 파일 생성 성공: {json_file}")
            print(f"총 {len(records)}개의 레코드가 변환되었습니다.")
            
            # 샘플 데이터 출력
            print("\n처음 2개 레코드 샘플:")
            for i, record in enumerate(records[:2]):
                print(f"레코드 {i+1}:", record)
                
            return True
        else:
            print("변환할 컬럼이 없습니다.")
            return False
            
    except Exception as e:
        print(f"오류 발생: {str(e)}")
        return False

# 실행 코드
if __name__ == "__main__":
    # 파일 경로 설정
    input_file = "card_bin_table.xlsx"
    output_file = "card_bin_table.json"
    
    # 입력 파일 존재 확인
    if not os.path.exists(input_file):
        print(f"입력 파일이 존재하지 않습니다: {input_file}")
        # 사용자 입력 받기
        input_file = input("엑셀 파일의 전체 경로를 입력하세요: ")
    
    # 변환 실행
    excel_to_json(input_file, output_file)